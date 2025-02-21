# Netflix Movies and TV Shows Data Analysis using SQL

![Netflix logo](https://github.com/user-attachments/assets/5182c680-2081-4e0d-8f80-565c5be19557){ width=300 }


### **Netflix Data Analysis Using SQL Server**  

#### **Overview**  
This project aims to analyze Netflix's movie and TV show data to extract valuable insights and answer key business questions. SQL queries are used to analyze content types, geographical distribution, ratings, duration, and other aspects of the available content.  

#### **Objectives**  
1. Analyze the distribution of content between movies and TV shows.  
2. Identify the most common ratings for movies and TV shows.  
3. Explore content based on release years, countries, and durations.  
4. Categorize and analyze content based on specific criteria and keywords.  

#### **Dataset Source**  
The dataset was sourced from Kaggle and can be accessed via the following link:  
[Netflix Dataset on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)  

---

### **Business Problems and Solutions**  

#### **1. Count the Number of Movies vs. TV Shows**  
```sql
SELECT 
    type, 
    COUNT(*) AS count 
FROM netflix_titles$
GROUP BY type;
```
**Objective:** Determine the distribution of content types on Netflix.  

#### **2. Find the Most Common Rating for Movies and TV Shows**  
```sql
WITH RatingCounts AS (
    SELECT 
        type, 
        rating, 
        COUNT(*) AS rating_count
    FROM netflix_titles$
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type, 
        rating, 
        rating_count, 
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT 
    type, 
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;
```
**Objective:** Identify the most frequently occurring rating for each type of content.  

#### **3. List All Movies Released in a Specific Year (e.g., 2020)**  
```sql
SELECT * 
FROM netflix_titles$
WHERE release_year = 2020;
```
**Objective:** Retrieve all movies released in a specific year.  

#### **4. Find the Top 5 Countries with the Most Content on Netflix**  
```sql
SELECT TOP 5 
    country, 
    COUNT(*) AS total_content
FROM netflix_titles$
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC;
```
**Objective:** Identify the top 5 countries with the highest number of content items.  

#### **5. Identify the Longest Movie**  
```sql
SELECT TOP 1 *
FROM netflix_titles$
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING(duration, 1, CHARINDEX(' ', duration) - 1) AS INT) DESC;
```
**Objective:** Find the movie with the longest duration.  

#### **6. Find Content Added in the Last 5 Years**  
```sql
SELECT * 
FROM netflix_titles$
WHERE date_added IS NOT NULL 
AND YEAR(CAST(date_added AS DATE)) >= YEAR(GETDATE()) - 5;
```
**Objective:** Retrieve content added to Netflix in the last 5 years.  

#### **7. Find All Movies/TV Shows by a Specific Director (e.g., 'Rajiv Chilaka')**  
```sql
SELECT * 
FROM netflix_titles$
WHERE director LIKE '%Rajiv Chilaka%';
```
**Objective:** List all content directed by 'Rajiv Chilaka'.  

#### **8. List All TV Shows with More Than 5 Seasons**  
```sql
SELECT * 
FROM netflix_titles$
WHERE type = 'TV Show' 
AND CAST(SUBSTRING(duration, 1, CHARINDEX(' ', duration) - 1) AS INT) > 5;
```
**Objective:** Identify TV shows with more than 5 seasons.  

#### **9. Count the Number of Content Items in Each Genre**  
```sql
SELECT 
    listed_in AS genre, 
    COUNT(*) AS total_content
FROM netflix_titles$
GROUP BY listed_in
ORDER BY total_content DESC;
```
**Objective:** Count the number of content items in each genre.  

#### **10. Find the Top 5 Years with the Highest Average Content Releases in India**  
```sql
SELECT TOP 5 
    release_year, 
    COUNT(show_id) AS total_releases,
    ROUND(COUNT(show_id) * 100.0 / 
        (SELECT COUNT(show_id) FROM netflix_titles$ WHERE country = 'India'), 2) AS avg_release_percentage
FROM netflix_titles$
WHERE country = 'India'
GROUP BY release_year
ORDER BY avg_release_percentage DESC;
```
**Objective:** Calculate and rank years by the average number of content releases in India.  

#### **11. List All Movies that are Documentaries**  
```sql
SELECT * 
FROM netflix_titles$
WHERE listed_in LIKE '%Documentaries%';
```
**Objective:** Retrieve all movies classified as documentaries.  

#### **12. Find All Content Without a Director**  
```sql
SELECT * 
FROM netflix_titles$
WHERE director IS NULL;
```
**Objective:** List content that does not have a director.  

#### **13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years**  
```sql
SELECT * 
FROM netflix_titles$
WHERE casts LIKE '%Salman Khan%' 
AND release_year >= YEAR(GETDATE()) - 10;
```
**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.  

#### **14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India**  
```sql
SELECT TOP 10 
    casts AS actor, 
    COUNT(*) AS movie_count
FROM netflix_titles$
WHERE country = 'India'
GROUP BY casts
ORDER BY movie_count DESC;
```
**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.  

#### **15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords**  
```sql
SELECT 
    CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS content_count
FROM netflix_titles$
GROUP BY CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END;
```
**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.  

---

### **Findings and Conclusions**  
- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.  
- **Common Ratings:** Insights into the most common ratings help understand the content’s target audience.  
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.  
- **Content Categorization:** Categorizing content based on specific keywords provides insights into the nature of Netflix’s available content.  



