create database imdb;
select * from actor;
select * from cast;
select * from director;
select * from genres;
select * from movie;
select * from movie_direction;
select * from movie_genres;
select * from ratings;

-- Q1) Write a query where it should contain all the data of the movies which were released after 1995 having their movie duration greater than 120 and should be including A in their movie title.

select * from movie
where mov_title like '%a%' and mov_year > 1995 and mov_time

-- q2) Write an SQL query to find the actors who played a role in the movie 'Chinatown'. Fetch all the fields of actor table. (Hint: Use the IN operator

select * from actor;
select * from actor
where act_id in ( select act_id from cast 
where mov_id in( select mov_id from movie 
where mov_title = 'Chinatown'));

-- q3)Write an SQL query for extracting the data from the ratings table for the movie who got the maximum number of ratings.

select * from ratings;
select mov_title, max(num_o_ratings) as max_ratings from movie,ratings
where movie.mov_id = ratings.mov_id 
group by mov_title
order by  max_ratings desc;

-- q4) Write an SQL query to determine the Top 7 movies which were released in United Kingdom. Sort the data in ascending order of the movie year.

select * from movie;
select * from ratings;

select m.mov_title,m.mov_year, r.rev_stars from
movie as m inner join ratings as r
on m.mov_id = r.mov_id
where mov_rel_country = 'UK'
order by m.mov_year asc limit 7;

-- q5) Set the language of movie language as 'Chinese' for the movie which has its existing language as Japanese and their movie year was 2001.

update movie 
set mov_lang = 'Chinese'
where mov_lang = 'Japanese'
and mov_year = 2001;
select * from movie;

-- q6) Print genre title, maximum movie duration and the count the number of movies in each genre.

select * from genres;
select * from movie;
select * from movie_genres;
select g.gen_title, max(mov_time) as max_duaration, count(g.gen_title) as gen_count 
from
movie as m join movie_genres as mg on m.mov_id = mg.mov_id
join genres as g on mg.gen_id = g.gen_id
group by g.gen_title;

-- q7) Create a view which should contain the first name, last name, title of the movie & role played by particular actor.

select * from actor;
select * from cast;
select * from movie;

create view actors as
(
select a.act_fname,a.act_lname,m.mov_title, c.role
from actor as a inner join cast as c on a.act_id = c.act_id
inner join movie as m on c.mov_id = m.mov_id);
select * from actors;

-- q8) Display the movies that were released before 31st March 1995.

select mov_title from movie
where mov_dt_rel < '3/31/1995';

-- q9) Write a query which fetch the first name, last name & role played by the actor where output should all exclude Male actors.

select a.act_fname,a.act_lname,m.mov_title, c.role
from actor as a inner join cast as c on a.act_id = c.act_id
inner join movie as m on c.mov_id = m.mov_id
where not a.act_gender = 'M';

-- q10) Insert five rows into the cast table where the ids for movie should be 936,939,942,930,941 and their respective roles should be Darth Vader, Sarah Connor, Ethan Hunt, Travis Bickle, Antoine Doinel & their actor ids should be set up as 126,140,135,131,144.

select * from cast;
insert into cast (mov_id,role,act_id) 
values
(936, 'Darth vader', 126),
(939, 'sarah connor',140),
(942, 'ethan hunt',135),
(930,'travis bickle',131),
(941,'antoine doinel',144);
select * from cast;

