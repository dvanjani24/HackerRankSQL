
/*
Using benn.college_football_players database:
full_school_name, string
height, float
hometown, string
id, integer
player_name, string
position, string
school_name, string
state, string
weight, float
year, string
*/

/*
Write a query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total number of players. Order results such that states with the most players come first.
*/

select
state,
count(case when year = 'FR' then 1 else null end) as fr_count, 
count(case when year = 'SO' then 1 else null end) as so_count,
count(case when year = 'JR' then 1 else null end) as jr_count,
count(case when year = 'SR' then 1 else null end) as sr_count,
count(1)
from benn.college_football_players
group by state
order by total_count desc;

/*
Write a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.
*/

select
case 
when left(school_name,1) between 'A' and 'M' then 'A-M'
when left(school_name,1) between 'N' and 'Z' then 'N-Z'
end as name_split, 
count(1)
from benn.college_football_players
group by name_split;




