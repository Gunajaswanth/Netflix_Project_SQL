DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);


SELECT * FROM netflix;

SELECT 
	COUNT(*) AS total_content
FROM netflix;

SELECT 
	DISTINCT type
FROM netflix;

--15 Business Problems
-- 1. Count the number of Movies vs TV Shows
SELECT 
	type,
	COUNT(*) AS total_content 
FROM netflix
GROUP BY type;

-- 2. Find thew most common rating for movies and TV shows
SELECT 
	type,
	rating
FROM 
(
	SELECT 
			type,
			rating,
			COUNT(*),
			RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
	FROM netflix
	GROUP BY 1, 2
) AS t1
WHERE ranking = 1

-- 3. List all the movies released in a specific year (e.g. 2020)
SELECT * FROM netflix
WHERE 
	type = 'Movie'
	AND 
	release_year = 2020;

-- 4. Find the top 5 countires with the most content on netflix
SELECT 
	UNNEST(STRING_TO_ARRAY(country, ',')) AS new_country,
	COUNT(show_id) as toal_content 
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- 5. Identify the lingest movie
SELECT * FROM netflix
WHERE 
	type = 'Movie'
	AND
 	duration = (SELECT MAX(duration) FROM netflix)

-- 6. Find content added in the last 5 years
SELECT
    *
FROM
    netflix
WHERE
    -- Ensure date_added follows the "DD-Mon-YY" format
    date_added ~ '^[0-9]{2}-[A-Za-z]{3}-[0-9]{2}$'
    AND TO_DATE(date_added, 'DD-Mon-YY') >= CURRENT_DATE - INTERVAL '5 years'

-- 7. Find all the movies and the TV shows by director 'Rajiv Chilaka'
SELECT * FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%'

-- 8. List all the TV shows with more than 5 seaons
SELECT * FROM netflix
WHERE 
	type = 'TV Show'
 	AND
	SPLIT_PART(duration,' ', 1)::numeric > 5

-- 9. Count the number of content items in each genre
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(show_id) AS total_content
	FROM netflix 
	GROUP BY 1 


-- 10. Find each year and the average numbers of content release by India on netflix. return top 5 year with highest avg content release.
SELECT 
    EXTRACT(YEAR FROM TO_DATE(
        CONCAT(SUBSTRING(date_added, 1, 2), '-', SUBSTRING(date_added, 4, 3), '-', SUBSTRING(date_added, 7, 2)), 
        'DD-Mon-YY')) AS year,
    COUNT(*) AS content_count,
    ROUND(COUNT(*)::numeric / NULLIF((SELECT COUNT(*) FROM netflix WHERE country = 'India'), 0)::numeric * 100, 2) AS avg_content_per_year
FROM netflix 
WHERE country = 'India'
  AND date_added ~ '^[0-9]{2}-[A-Za-z]{3}-[0-9]{2}$'  -- Ensure proper format using regex
GROUP BY year;


-- 11. List all the movies that are Documentaries
SELECT * FROM netflix
WHERE listed_in ILIKE '%Documentaries%'; 


-- 12. Find all the content without a director
SELECT * FROM netflix
WHERE director is null; 


-- 13.Find how many movies 'Salman khan' appeared in the last 10 years
SELECT * FROM netflix 
WHERE 
	casts ILIKE '%Salman Khan%'
	AND
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


-- 14. Find the top 10 actors who have appeared in the highest no of movies produced in  India

SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) AS actors,
	COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10 


-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content 
-- containing these keywords as 'Bad' all other content as 'Good'. Count how many times fall into each category

WITH new_table
AS 
(
SELECT 
	*,
	CASE 
	WHEN
		description ILIKE '%kill%' OR 
		description ILIKE '%violence%' THEN 'Bad_ Content'
		ELSE 'Good Content'
	END category 
FROM netflix
)
SELECT 
	category,
    COUNT(*) AS total_content
FROM new_table
GROUP BY 1