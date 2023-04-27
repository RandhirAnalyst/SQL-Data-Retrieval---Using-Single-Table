-- 'use' function is used to access database, here moviesdb is the database.
use moviesdb;

-- we are going to perform query on text(string) values
-- find distinct industry in movies making
SELECT distinct(industry)  as distinct_industry FROM movies;

-- find all bollywood momvies
select * from movies
 where industry= 'bollywood';

-- find all all moveis which start with thor
select * from movies
 where title like "%thor%";

-- find distinct studio 
SELECT distinct(studio)  as distinct_studio FROM movies;

-- find how many records are present in movies dataset
SELECT  count(*) as records FROM movies;

-- 1. Print all movie titles and release year for all Marvel Studios movies.
select title, release_year from movies
 where studio ='Marvel Studios' ;
 
-- 2. Print all movies that have Avenger in their name.
select * from movies
 where title like "%avenger%";
 
-- 3. Print the year when the movie "The Godfather" was released.
select release_year from movies
 where title ='The Godfather';
 
-- 4. Print all distinct movie studios in the Bollywood industry.
select distinct(studio) from movies
 where industry ="bollywood";


-- we are going to perform query on numberic values
-- 1. Print all movies in the order of their release year (latest first) 
select 
   title, release_year 
from movies
order by release_year desc;

-- 2. All movies released in the year 2022
select 
   title, release_year 
from movies
where release_year =2022;

-- 3. Now all the movies released after 2020
select 
   title, release_year 
from movies
where release_year >2020;

-- 4. All movies after the year 2020 that have more than 8 rating
select 
   title, imdb_rating 
from movies
where release_year >2020 and 
      imdb_rating >8;

-- 5. Select all movies that are by Marvel studios and Hombale Films
select 
   title, studio
from movies
where studio in ("marvel studios", "hombale Films");

-- and you can write this query in this way too
select 
   title, studio
from movies
where studio ="marvel studios" or 
	  studio ="hombale Films";

-- 6. Select all THOR movies by their release year
select 
   title, release_year
from movies
where title like "%thor%"                                                                     
order by release_year desc;

-- 7. Select all movies that are not from Marvel Studios
select 
   title, studio
from movies
where studio <> "Marvel Studios";  -- <> operator is not equal operator


-- we are going to perform analytics query
-- Summary analytics (MIN, MAX, AVG, GROUP BY)

-- 1. How many movies were released between 2015 and 2022
select 
   count(*)
from movies
where release_year between 2015 and 2022;

-- 2. Print the max and min movie release year
select 
    max(release_year) as max_relase_year,
    min(release_year) as min_relase_year
from movies;

-- 3. Print a year and how many movies were released in that year starting with the latest year
select 
   release_year,
   count(title) as count_movies
from movies
group by release_year
order by release_year desc;

-- 4. Print the avg rating of all studios
select 
   studio,
   round(avg(imdb_rating),1) as avg_imdb_rating
from movies
group by studio
order by avg_imdb_rating desc;

-- retriev table had one null values in studio column, therefore fix it
select 
   studio,
   round(avg(imdb_rating),1) as avg_imdb_rating
from movies
where studio <> "" # not equal( <> ) operator will not fetch that records where studio column will have null values
group by studio
order by avg_imdb_rating desc;

-- 5. Print industry (like bollywood or hollywood) with thier movies count
select 
   industry,
   count(title) as count_movies
from movies
group by industry
order by count_movies desc;

-- using having clause
-- The order of query execution in SQL is 
-- FROM → WHERE → GROUP BY → HAVING → ORDER BY
-- 1. print all years where more than 2 moveis were released
select 
   release_year,
   count(title) as movies_count
from movies
group by release_year
having movies_count>2
order by movies_count desc;

-- 2. print all years where more than 2 moveis were released
--    and movies imdb rating should be more than 6 .
select 
   release_year,
   count(title) as movies_count
from movies
where imdb_rating>6
group by release_year
having movies_count>2
order by movies_count desc;

-- Note:- The column you use in HAVING should be present in SELECT clause whereas, 
--        WHERE can use columns that is not present in select clause as well


-- we are going to create a derive column (age) in actors table
select 
    *,
    year(CURDATE())-birth_year as age
from actors;

-- create a profit column in financials table
select 
    *,
    revenue-budget as profit
from financials;

-- we are going to create derive column revenue_inr in financials table
-- we will use if statement here
-- IF(condition: true, false)
-- note:- if statemetn use when we have only one conditon
select 
    *,
    if(currency="usd", revenue*80, revenue) as revenue_inr
from financials;

-- create new calculate column in financials table and revenue should be one unit (in million)
-- here we will use case--end statement because
-- we have more than one conditions
select 
    *,
    case
        when unit='billions' then revenue*1000
        when unit='thousands' then revenue/1000
        else revenue
    end as revenue_mln
from financials;


-- print the profit and profit% in financials table
with profit_table as( select 
                   *,
				revenue-budget as profit
                from financials)
select
   *,
   round((profit*100)/revenue,2) as profit_pct
from profit_table;

-- print profit and profit% (without CTE- Comman Table Expression)
select 
    *,
    revenue-budget as profit,
    round((revenue-budget)*100/revenue,2) as profit_pct
from financials;












