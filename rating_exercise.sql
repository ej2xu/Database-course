-- dbext:type=mySQL

-- Question 1
-- find the titles of all movies directed by steven spielberg
select title
from Movie
where director = 'Steven Spielberg';

-- Question 2
-- Find all years that have a movie that received a rating of 4 or 5,
-- and sort them in increasing order.

select year
from Movie
where mID in (select mID from Rating where stars = 4 or stars = 5)
order by year;

-- Question 3
-- Find the titles of all movies that have no ratings.
select title
from Movie
where mID not in (select mID from Rating where not stars is null);

-- Question 4
-- Some reviewers didn't provide a date with their rating.
-- Find the names of all reviewers who have ratings with a NULL value for the date.
select name
from Reviewer
where rID in (select rID from Rating where ratingDate is null);

-- Question 5
-- Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate.
-- Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
select name, title, stars, ratingDate
from (Rating join Reviewer using(rID)) join Movie using(mID)
order by name, title, stars;

-- Question 6
-- For all cases where the same reviewer rated the same movie twice and
-- gave it a higher rating the second time, return the reviewer's name and the title of the movie.
select name, title
from ((select rID, mID from Rating r1 join Rating r2 using(rID, mID)
where r1.stars > r2.stars and r1.ratingDate > r2.ratingDate) R_M
join Movie using(mID)) join Reviewer using(rID);

-- Question 7
-- For each movie that has at least one rating,
-- find the highest number of stars that movie received.
-- Return the movie title and number of stars. Sort by movie title.
select title, ms
from Movie join (select mID, max(stars) as ms
            from Rating
            group by mID) m using(mID)
order by title;

-- Question 8
-- For each movie, return the title and the 'rating spread',
-- that is, the difference between highest and lowest ratings given to that movie.
-- Sort by rating spread from highest to lowest, then by movie title.
select title, max(stars) - min(stars) as spread
from Movie join Rating using(mID)
group by mID, title
order by spread DESC, title;

-- Question 9
-- Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980.
-- (Make sure to calculate the average rating for each movie,
-- then the average of those averages for movies before 1980 and movies after.
-- Don't just calculate the overall average rating before and after 1980.)
select avg(b.average) - avg(a.average)
from (select avg(stars) as average, year
    from Movie join Rating using(mID)
    where year < 1980
    group by mID, year) b,
    (select avg(stars) as average, year
    from Movie join Rating using(mID)
    where year > 1980
    group by mID, year) a;
