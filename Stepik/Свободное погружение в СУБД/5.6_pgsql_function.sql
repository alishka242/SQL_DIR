-- Создание таблиц и вставка
CREATE TABLE Conference(
  id INT PRIMARY KEY, name TEXT UNIQUE);

CREATE TABLE ConferenceEvent(
  id SERIAL PRIMARY KEY,
	conference_id INT, -- REFERENCES Conference,
	year INT,
	UNIQUE(conference_id, year));

CREATE TABLE Paper(
  id INT PRIMARY KEY,
  event_id INT, -- REFERENCES ConferenceEvent,
  title TEXT,
  accepted BOOLEAN
);

CREATE TABLE Reviewer(
  id INT PRIMARY KEY,
  email TEXT UNIQUE,
  name TEXT
);

CREATE TABLE PaperReviewing(
  paper_id INT, -- REFERENCES Paper,
  reviewer_id INT, -- REFERENCES Reviewer,
  score INT,
  UNIQUE(paper_id, reviewer_id)
);

INSERT INTO Conference(id, name) VALUES (1, 'SIGMOD'), (2, 'VLDB');
INSERT INTO ConferenceEvent(conference_id, year) VALUES (1, 2015), (1, 2016), (2, 2016);
INSERT INTO Reviewer(id, email, name) VALUES
  (1, 'jennifer@stanford.edu', 'Jennifer Widom'),
  (2, 'donald@ethz.ch', 'Donald Kossmann'),
  (3, 'jeffrey@stanford.edu', 'Jeffrey Ullman'),
  (4, 'jeff@google.com', 'Jeffrey Dean'),
  (5, 'michael@mit.edu', 'Michael Stonebraker');

INSERT INTO Paper(id, event_id, title) VALUES
  (1, 1, 'Paper1'),
  (2, 2, 'Paper2'),
  (3, 2, 'Paper3'),
  (4, 3, 'Paper4');

INSERT INTO PaperReviewing(paper_id, reviewer_id) VALUES
  (1, 1), (1, 4), (1, 5),
  (2, 1), (2, 2), (2, 4),
  (3, 3), (3, 4), (3, 5),
  (4, 2), (4, 3), (4, 4);

/* Связи между таблицами:
    PaperReviewing.paper_id - foreign key for Paper.id
    PaperReviewing.reviewer_id - foreign key for ConferenceEvent.id
    Paper.event_id  - foreign key for Paper.id
    ConferenceEvent.conference_id - foreign key for Conference.id

    Объекты:
    Conference - конференция
    ConferenceEvent - событие связанное с конференцией
    Paper - сатья для конференции
    Paper.accepted - BOOLEAN значение означающее принята статья ли нет
    Reviewer - рецензенты, которые голосуют за статью (отношение суммы оценок от 3-ех рецензентов деленое на 3, определяет будет ли статья допущена)
    PaperReviewing - таблица Paper и Reviewer с оценками.
*/

/* Задача:
    Написать хранимую ф-ию, в которой будут соблюдаться ограничения и обновляться 2 поля 2-ух таблиц:
    1) PaperReviewing.score - будут добавляться оценки от ревьюеров для статей
    2) Paper.accepted - вставляется значение TRUE/FALSE в зависимости от отношения суммы оценок конкретной стаьи от 3-ех рецензентов деленое на кол-во резидентов
    
    ХФ должна обновить запись о рецензировании, если таковая имеется, и записать туда оценку, если этому не препятствуют описанные далее ограничения. Кроме этого, если для статьи получено три оценки, то процедура должна в момент получения третьей оценки записать в атрибут Paper.accepted посчитанное значение. Это значение должно быть TRUE, если среднее арифметическое оценок больше 4, и  FALSE в противном случае.
    ХФ должна завершиться успешно только в том случае, если она выполнила необходимые действия. Если действие выполнить невозможно по причине некорректности данных или по еще какой-нибудь причине, процедура должна выкинуть исключение с кодом 'DB017'. В PostgreSQL это делается так:
        RAISE SQLSTATE 'DB017';
    
    Интерфейс хранимой ф-ии
    У вашей хранимой ф-ии такой интерфейс. Он фиксирован и менять его нельзя.

    SubmitReview(_paper_id INT, _reviewer_id INT, _score INT)
    RETURNS VOID
    Требуется написать тело процедуры. Оно будет вставлено на место комментария -- YOUR CODE HERE в нижеприведённом фрагменте:
        CREATE OR REPLACE FUNCTION SubmitReview(_paper_id INT, _reviewer_id INT, _score INT)
        RETURNS VOID AS $$
        -- YOUR CODE HERE
        $$ LANGUAGE plpgsql;

    Помните, что тело должно содержать ключевые слова BEGIN и END; и может содержать секцию DECLARE с объявлением переменных. Пример валидного, но неправильного ответа:
        DECLARE 
        result BOOLEAN;
        BEGIN
        RAISE SQLSTATE 'DB017';
        END;

    Ограничения:
    1) Оценками могут быть целые числа в диапазоне [1..7]
    2) Единожды поставленное значение решения о принятии или отклонении статьи и оценки рецензентов, на основании  которых решение было поставлено, не должны меняться.
    3) Добавлять новые записи о рецензировании не нужно.
*/  

-- Решение

CREATE OR REPLACE FUNCTION SubmitReview(_paper_id INT, _reviewer_id INT, _score INT)
  RETURNS VOID AS $$
DECLARE result BOOLEAN;
BEGIN
	CASE 
		WHEN _score < 1 OR _score > 7 
			THEN RAISE SQLSTATE 'DB017';
		WHEN (SELECT paper_id
				FROM PaperReviewing
				WHERE paper_id = _paper_id AND reviewer_id = _reviewer_id
				) IS NULL 
			THEN RAISE SQLSTATE 'DB017';
		WHEN
			((SELECT id FROM Paper WHERE id = _paper_id) IS NULL 
			OR (SELECT id FROM Reviewer WHERE id = _reviewer_id) IS NULL) 
			THEN RAISE SQLSTATE 'DB017';
		WHEN (SELECT accepted FROM Paper WHERE id = _paper_id) IS NOT NULL 
			THEN RAISE SQLSTATE 'DB017';
		ELSE 
			UPDATE PaperReviewing
			SET score = _score 
			WHERE paper_id = _paper_id AND reviewer_id = _reviewer_id;
	END CASE;
	
	
	CASE 
		WHEN (
			SELECT COUNT(score) 
			FROM PaperReviewing 
			WHERE score IS NOT NULL AND paper_id = _paper_id
			GROUP BY paper_id
			) = 3 
			THEN
				CASE
					WHEN (
						SELECT ROUND(SUM(score) / COUNT(score))
						FROM PaperReviewing 
						WHERE score IS NOT NULL AND paper_id = _paper_id
						GROUP BY paper_id
						) >= 4 
						THEN 
							UPDATE Paper
							SET accepted = TRUE 
							WHERE id = _paper_id;
							
							result := TRUE;
					ELSE 
						UPDATE Paper
						SET accepted = FALSE 
						WHERE id = _paper_id;
						
						result := FALSE;
				END CASE;
			ELSE result := NULL;
	END CASE;

RETURN;
END;
$$ LANGUAGE plpgsql;

-- Доп. запросы для проверки, рестарта:
SELECT * FROM paper;

SELECT * FROM PaperReviewing;


UPDATE PaperReviewing 
SET score =  NULL
WHERE paper_id = 1 ;

UPDATE Paper 
SET accepted =  NULL
WHERE id = 1;



SELECT SubmitReview(1, 1, 3);
SELECT SubmitReview(1, 5, 4);
SELECT SubmitReview(1, 4, 5);