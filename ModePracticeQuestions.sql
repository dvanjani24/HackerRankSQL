
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

/*
Write a query that displays player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division.
*/

select p.player_name, p.school_name, t.conference 
from benn.college_football_players p 
inner join benn.college_football_teams t ON p.school_name = t.school_name 
where t.division = 'FBS (Division I-A Teams)'

/*
Count the number of unique companies (don't double-count companies) and unique acquired companies by state. Do not include results for which there is no state data, and order by the number of acquired companies from highest to lowest.
*/

SELECT companies.state_code,
       COUNT(DISTINCT companies.permalink) AS unique_companies,
       COUNT(DISTINCT acquisitions.company_permalink) AS unique_companies_acquired
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
 WHERE companies.state_code IS NOT NULL
 GROUP BY 1
 ORDER BY 3 DESC


/*
Cities with more customer's than average
*/


Select country.country_name, city.city_name, count(customer.customer_name)
from country
inner join city on city.country_id = country.id
inner join customer on customer.city_id = city.id
group by country.country_name, city.city_name
having count(customer.customer_name) > 
(
  Select count(customer.customer_name) / count(city.city_name) as avg_per_city
  from city
  inner join customer on customer.city_id = city.id
) 
