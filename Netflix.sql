

CREATE TABLE netflix_titles$
(
    show_id VARCHAR(6),
    type VARCHAR(10),
    title VARCHAR(150),
    director VARCHAR(208),
    casts VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(15),
    listed_in VARCHAR(100),
    description VARCHAR(250)
);

select * from netflix_titles$


select 
    count(*) as total_content 
from netflix_titles$


select 
   DISTINCT type
from netflix_titles$

select * from netflix_titles$

-- 1. Count the number of Movies vs TV Shows

SELECT 
     type,
	 count(*) as total_content
from netflix_titles$
group by type

-- 2. Find the most common rating for movies and TV shows

SELECT 
    type,
    rating
FROM  
(
  SELECT 
      type,
      rating,
      COUNT(*) AS rating_count,
      RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
  FROM [netflix_titles$]  
  GROUP BY type, rating
) AS t1 
WHERE ranking = 1;

-- 3. List all movies released in a specific year (e.g., 2020)

--filter 2020
--movies

SELECT *
FROM netflix_titles$
WHERE
    type ='movie'
	and
	release_year = 2020

-- 4. Find the top 5 countries with the most content on Netflix

SELECT TOP 5 country, COUNT(*) as total_content
FROM netflix_titles$
WHERE country is not null
group by country
order by total_content desc

-- 5. Identify the longest movie

SELECT TOP 1 * FROM netflix_titles$
WHERE 
     type = 'Movie'
	 AND
	 duration = (SELECT MAX(duration) FROM netflix_titles$)


-- 6. Find content added in the last 5 years

SELECT *
FROM netflix_titles$
WHERE TRY_CAST(date_added AS date) >= DATEADD(year, -5, GetDate());

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT * 
FROM netflix_titles$
WHERE director =  'Rajiv Chilaka'

-- 8. List all TV shows with more than 5 seasons

SELECT * 
FROM netflix_titles$
WHERE type = 'TV Show'  
AND CAST(LEFT(duration, CHARINDEX(' ', duration) - 1) AS INT) > 5;

-- 9. Count the number of content items in each genre

SELECT listed_in as genre, COUNT(*) as total_content
FROM netflix_titles$
GROUP BY listed_in

-- 10. Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !

SELECT TOP 5 
    release_year, 
    COUNT(*) AS total_content
FROM netflix_titles$
WHERE country = 'India'
GROUP BY release_year
ORDER BY total_content DESC;


-- 11. List all movies that are documentaries

SELECT *
FROM netflix_titles$
WHERE type = 'Movie'
AND listed_in LIKE '%Documentaries%'


-- 12. Find all content without a director

SELECT * FROM netflix_titles$
WHERE director IS NULL


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT COUNT(*) AS total_movies
FROM netflix
WHERE 
    casts LIKE '%Salman Khan%'
    AND release_year > YEAR(GETDATE()) - 10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

WITH ActorList AS (
    SELECT 
        TRIM(value) AS actor  
    FROM netflix_titles$
    CROSS APPLY STRING_SPLIT(cast, ',') 
    WHERE country = 'India' AND type = 'Movie'
)
SELECT TOP 10 
    actor, 
    COUNT(*) AS num_movies
FROM ActorList
GROUP BY actor
ORDER BY num_movies DESC;

/*
Question 15:
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/

SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE
            WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix_titles$
) AS categorized_content
GROUP BY category
ORDER BY content_count DESC;




