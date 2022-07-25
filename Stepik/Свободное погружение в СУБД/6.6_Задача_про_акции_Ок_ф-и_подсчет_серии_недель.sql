--Ссылка на задачу: https://stepik.org/lesson/344702/step/5?auth=login&unit=328392

--Данные
/*
/*
-- Stepik Course.
-- database sample for task 5.4
 
DROP TABLE IF EXISTS StockQuotes;
 
CREATE TABLE StockQuotes(
  company TEXT,
  week INT,
  share_price INT
  );
 
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  1,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  2,  15);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  3,  20);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  4,  25);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  5,  30);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  6,  35);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  7,  40);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  8,  45);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple',  9,  50);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 10,  60);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 11,  70);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 12,  80);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 13,  90);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 14,  90);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 15, 100);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 16, 100);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 17, 100);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 18, 100);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 19, 100);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Apple', 20,  90);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  1,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  2,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  3,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  4,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  5,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  6,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  7,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  8,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  9,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  10,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  11,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  12,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  13,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  14,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  15,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  16,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  17,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  18,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  19,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Oracle',  20,  10);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  1, 100);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  2,  95);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  3,  95);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  4,  90);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  5,  90);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  6,  85);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  7,  80);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  8,  100);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  9,  120);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  10, 150);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  11, 100);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  12,  90);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  13,  90);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  14,  85);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  15,  80);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  16,  75);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  17,  70);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  18,  70);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  19,  65);
INSERT INTO StockQuotes (company, week, share_price) VALUES ('Microsoft',  20,  60);
*/

/*Задача 

Это задание настоятельно рекомендуется решать с помощью оконных функций. Вам может пригодиться документация.

Позанимаемся анализом биржевых котировок.

У вас есть таблица StockQuotes(company TEXT, week INT, share_price INT). Строка в этой таблице говорит о том, что стоимость акции компании company в неделю номер week составляла share_price.

Назовём индексом в данную неделю среднее арифметическое роста стоимости одной акции по всем компаниям сравнительно с предыдущей неделей. То есть, если одна акция компании A подорожала на 100 единиц, а акция компании B подешевела на 50 единиц, то индекс равен 25.

Назовём компанию успешной на этой неделе, если изменение стоимости одной её акции было выше индекса. "Изменение D выше индекса I" означает "D > I" как вещественное число.

Если компания была успешной три недели подряд то будем говорить, что она сделала успешную серию. Успешные серии могут пересекаться. Так, если компания была успешной 5 недель подряд, то у неё было 3 успешных серии.

Вам нужно посчитать для каждой компании количество успешных серий и вывести в результат два столбца. В первом столбце с типом TEXT должно быть название компании, а во втором с типом BIGINT количество её успешных серий. Тип BIGINT, скорее всего, получится автоматически, но вы можете явно привести результат оператором ::BIGINT. При несоответствии типов ожидаемым  вам предложат проверить, нет ли в запросе синтаксических ошибок и возвращает ли он ровно то, что требуется. Это же сообщение может появиться и по другим поводам, например если у вас действительно есть синтаксические ошибки.

Компании, у которых не было успешных серий, выводить в результат не надо совсем.
Все компании различные.
Все цены положительные.
Нумерация недель начинается с 0. На неделе номер 0, разумеется, не определены рост и индекс -- вы можете считать что они 0, NULL или просто игнорировать нулевую неделю тем или иным способом при расчёте успешных недель.

Пример валидного, но неправильного ответа:

SELECT 'Foo'::TEXT, 0::BIGINT
*/

--Коммент к задаче
/*
1) Считаем с помощью оконных функций для компании сумму на этой недели минус сумму на предыдущей AS delta_prev
2) С помощью оконных функций находим сумму delta_prev по всем компаниям для каждой недели и делим на кол-во компаний также посчитанных для каждой недели AS index_week
3) delta_prev > index_week 
4) Я с помощью CASE WHEN и оконных функций, проставила 1 той записи, после которой 2 строки на один больше, чем текущая неделя. Затем посчитала сумму, сгруппировав  по компаниям. тут нужно быть внимательными, потому что сумма из пункта 5 считается по этим единичкам.
5) Вывести нужно название компании и сумму удачных серий. Если таких серий не было, компанию не выводить. Прочитайте и можно даже на листочке порисовать, чтобы понять, что это значит: 
Если компания была успешной три недели подряд то будем говорить, что она сделала успешную серию. Успешные серии могут пересекаться. Так, если компания была успешной 5 недель подряд, то у неё было 3 успешных серии.

*/

--Решение

WITH changes 
	AS (
	SELECT 
		company,
		week,
		share_price,
		(share_price - LAG(share_price, 1, share_price) OVER (PARTITION BY company ORDER BY week))::BIGINT delta_prev
	FROM stockquotes
	),
	lag_avg_week
	AS (
	SELECT 
		company,
		week,
		share_price,
		delta_prev,
		ROUND(SUM(delta_prev) OVER(PARTITION BY week) / COUNT(company) OVER(PARTITION BY week))  as index_week
	FROM changes
	),
	best_ac
	AS (
	SELECT *
	FROM lag_avg_week
	WHERE delta_prev > index_week
	),
	best_seria
	AS (
	SELECT company,
		CASE 
			WHEN 
				LEAD(week, 1, 0) OVER comp_week - week = 1
					AND
				LEAD(week, 2, 0) OVER comp_week - LEAD(week, 1, 0) OVER comp_week = 1
			THEN 1
			ELSE 0
		END AS sum_sec
	FROM best_ac
	WINDOW comp_week AS (PARTITION BY company ORDER BY week)
		ORDER BY company, week 
	)

SELECT company, SUM(sum_sec) 
FROM best_seria
GROUP BY company
HAVING SUM(sum_sec) > 0