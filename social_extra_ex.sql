-- dbext:type=MySQL

-- Question 1
-- For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.
select H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Likes L1, Likes L2, Highschooler H1, Highschooler H2, Highschooler H3
where L1.ID2 = L2.ID1
and L2.ID2 <> L1.ID1
and L1.ID1 = H1.ID and L1.ID2 = H2.ID and L2.ID2 = H3.ID;

-- Question 2
-- Find those students for whom all of their friends are in different grades from themselves.  Return the students' names and grades.
select distinct name, grade
from Highschooler, Friend
where ID = ID1
and ID not in (
  select H1.ID
  from Highschooler H1, Friend, Highschooler H2
  where H1.ID = ID1
  and H2.ID = ID2
  and H1.grade = H2.grade
);

-- Question 3
-- What is the average number of friends per student? (Your result should be just one number.)
select avg(numFriends)
from (
  select count(*) as numFriends
  from Friend
  group by ID1
) c;

-- Question 4
-- Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra.
-- Do not count Cassandra, even though technically she is a friend of a friend.
select count(distinct F1.ID2) + count(distinct F2.ID2)
from Friend F1, Friend F2, Highschooler
where Highschooler.name = 'Cassandra'
and ID = F1.ID1
and F1.ID2 = F2.ID1
and F2.ID2 <> ID;

-- Question 5
-- Find the name and grade of the student(s) with the greatest number of friends.
select name, grade
from Highschooler
where ID in (
  select ID1
  from friends
  group by ID1
  having count(*) in (
    select max(c)
    from 
  )
)
