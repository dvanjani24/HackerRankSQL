/* You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, 
name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, 
then sort the result by ascending hacker_id. Exclude all hackers with a total score of 0 from your result.
*/

select m.hacker_id, h.name, sum(score) as total_score
from (select hacker_id, challenge_id, max(score) as score from submissions
     group by hacker_id, challenge_id) as m
inner join hackers h on m.hacker_id = h.hacker_id
group by m.hacker_id, h.name
having total_score > 0
order by total_score desc, m.hacker_id asc;

/*
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent)
and their respective average city populations (CITY.Population) rounded down to the nearest integer.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

select country.continent, floor(avg(city.population))
from country inner join city on country.code = city.countrycode
group by country.continent;
