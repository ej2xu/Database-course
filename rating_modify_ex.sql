-- dbext:type=MySQL

-- Question 1
-- Add the reviewer Roger Ebert to your database, with an rID of 209.
insert into Reviewer values (209, 'Roger Ebert');

-- Question 2
-- Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL.
insert into Rating
  select distinct (select rID from Reviewer where name = 'James Cameron'), mID, 5, null
  from Movie;

-- Question 3
-- For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)
update Movie
set year = year + 25
where mID in (
  select mID
  from Movie join Rating using(mID)
  group by mID
  having avg(stars) >= 4
);

-- Question 4
-- Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars.
delete from Rating
where mID in (
  select mID
  from Movie join Rating using(mID)
  where year > 2000 or year < 1970
)
and stars < 4;
