-- 1. Give the name, release year, and worldwide gross of the lowest-grossing movie.
--name, specs.release_year, revenue.worldwide gross

SELECT film_title, release_year
FROM specs
LEFT JOIN revenue
ON revenue.movie_id = specs.movie_id
ORDER BY worldwide_gross ASC
LIMIT 1


-- 2. What year has the highest average imdb rating?
--spec.release_year, rating.imdb rating

SELECT release_year, film_title
FROM specs
LEFT JOIN rating
ON rating.movie_id = specs.movie_id
ORDER BY imdb_rating DESC


-- 3. What is the highest grossing G-rated movie? Which company distributed it?
-- specs.mpaa_rating, distributors, spec

SELECT mpaa_rating, company_name, worldwide_gross
FROM specs
LEFT JOIN distributors
ON distributors.distributor_id = specs.domestic_distributor_id
LEFT JOIN rating
ON rating.movie_id = specs.movie_id
LEFT JOIN revenue
ON revenue.movie_id = specs.movie_id
where mpaa_rating = 'G'
ORDER BY company_name DESC



-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table.
--Your result set should include all of the distributors, whether or not they have any movies in the movies table.
--distributors_name, specs.film_title,

select company_name, count(film_title)
from distributors
LEFT JOIN specs
ON distributors.distributor_id = domestic_distributor_id
where film_title is not null
group by company_name
order by company_name DESC

-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT company_name, film_budget
FROM distributors
LEFT JOIN specs
ON distributor_id = domestic_distributor_id
LEFT JOIN revenue
ON revenue.movie_id = specs.movie_id
WHERE company_name is not null
ORDER BY film_budget
LIMIT 5


-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? 
--Which of these movies has the highest imdb rating?
--distributor.company, distributor.headquartered, specs.film_title,rating.imdb rsating

SELECT COUNT(company_name), film_title, imdb_rating
FROM distributors
LEFT JOIN specs
ON domestic_distributor_id = distributor_id
LEFT JOIN rating
USING (movie_id)
where headquarters NOT LIKE'%CA%'
GROUP BY imdb_rating, film_title
ORDER BY imdb_rating DESC


-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?


SELECT
  CASE WHEN length_in_min > 120 THEN 'Over 2 Hours' ELSE 'Under 2 Hours' END AS length_category,
  AVG(imdb_rating)
FROM specs
LEFT JOIN rating
USING (movie_id)
GROUP BY length_in_min
ORDER BY length_in_min DESC

