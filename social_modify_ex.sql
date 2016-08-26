-- dbext:type=MySQL

-- Question 1
-- It's time for the seniors to graduate. Remove all 12th graders from Highschooler.
delete from Highschooler
where grade = 12;

-- Question 2
-- If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.
delete from Likes
where ID2 in (select ID2 from Friend where ID1 = Likes.ID1)
  and ID2 not in (select L.ID1 from Likes L where L.ID2 = Likes.ID1);

-- Question 3
-- For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself.
insert into Friend
  select F1.ID1, F2.ID2
  from Friend F1, Friend F2
  where F1.ID2 = F2.ID1 and F1.ID1 <> F2.ID2
  except
  select * from Friend;
