-- Extra exercises

-- Question 1
-- Find the names of all reviewers who rated Gone with the Wind.
select distinct name
from Reviewer, Movie, Rating
where Reviewer.rID = Rating.rID and Rating.mID = Movie.mID
and title = 'Gone with the Wind';

-- Question 2
-- For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
select name, title, stars
from (Reviewer join Rating using(rID)) join Movie using(mID)
where director = name;

-- Question 3
-- Return all reviewer names and movie names together in a single list, alphabetized.  (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)
select name
from Reviewer
union
select title
from Movie
order by name;

-- Question 4
-- Find the titles of all movies not reviewed by Chris Jackson.
select title from Movie
except
select title
from Reviewer, Movie, Rating
where Reviewer.rID = Rating.rID
and Rating.mID = Movie.mID
and name = 'Chris Jackson';

-- Question 5
-- For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.
select distinct R1.name, R2.name
from (Reviewer R1 join Rating Ra1 using(rID)), (Reviewer R2 join Rating Ra2 using(rID))
where Ra1.mID = Ra2.mID and R1.name < R2.name;

-- Question 6
-- For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.
select name, title, stars
from Reviewer, Movie, Rating
where stars in (select min(stars) from Rating)
and Reviewer.rID = Rating.rID
and Rating.mID = Movie.mID;

-- Question 7
-- List movie titles and average ratings, from highest-rated to lowest-rated.
-- If two or more movies have the same average rating, list them in alphabetical order.
select title, avg(stars) as av
from Rating join Movie using(mID)
group by mID, title
order by av DESC, title;

-- Question 8
-- Find the names of all reviewers who have contributed three or more ratings.
-- (As an extra challenge, try writing the query without HAVING or without COUNT.) 
