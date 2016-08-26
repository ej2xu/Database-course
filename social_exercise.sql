-- dbext:type=MySQL

-- Question 1
-- Find the names of all students who are friends with someone named Gabriel.
select name
from Highschooler
where ID in (
  select ID1
  from Friend, Highschooler
  where ID2 = ID and name = 'Gabriel'
);

-- Question 2
-- For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.
select H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1, Likes, Highschooler H2
where H1.ID = ID1 and H2.ID = ID2 and H1.grade - H2.grade >= 2

-- Question 3
-- For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
select H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1, Likes L1, Highschooler H2, Likes L2
where H1.ID = L1.ID1 and H2.ID = L1.ID2
  and H1.ID = L2.ID2 and H2.ID = L2.ID1
  and H1.name < H2.name;

-- Question 4
-- Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
select name, grade
from Highschooler
where ID not in (
  select ID1 from Likes
  union
  select ID2 from Likes
) order by grade, name;

-- Question 5
-- For every situation where student A likes student B, but we have no information about whom B likes
-- (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.
select H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1, Likes, Highschooler H2
where H1.ID = ID1 and H2.ID = ID2 and H2.ID not in (select ID1 from Likes);

-- Question 6
-- Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.
select name, grade
from Highschooler
where ID in (select ID1 from Friend)
  and ID not in (
    select ID1
    from Highschooler H1, Friend, Highschooler H2
    where H1.ID = Friend.ID1 and Friend.ID2 = H2.ID and H1.grade <> H2.grade)
order by grade, name;

-- Question 7
-- For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.
select distinct H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Highschooler H1, Likes, Highschooler H2, Highschooler H3, Friend F1, Friend F2
where H1.ID = Likes.ID1 and Likes.ID2 = H2.ID and H1.ID = F1.ID1 and F1.ID2 = H3.ID and F2.ID1 = H3.ID and F2.ID2 = H2.ID
  and H1.ID not in (select ID1 from Friend where ID2 = H2.ID);

-- Question 8
-- Find the difference between the number of students in the school and the number of different first names.
select s1.num - s2.numName
from (select count(*) as num from Highschooler) s1,
  (select count(distinct name) as numName from Highschooler) s2;

-- Question 9
-- Find the name and grade of all students who are liked by more than one other student. 
