WITH struct_info 
AS (
	SELECT 
		C.name, 
		CE.year, 
		event_id, 
		COUNT(1) total_papers,
		ROUND(SUM(Pap.accepted::INT)::numeric / COUNT(1)::numeric, 2) acceptance_ratio
	FROM Paper Pap
	JOIN ConferenceEvent CE ON Pap.event_id = CE.id
	JOIN Conference C ON CE.conference_id = C.id
	GROUP BY event_id, CE.year, C.name
)

SELECT * 
FROM struct_info
WHERE total_papers > 5 AND acceptance_ratio > 0.75;