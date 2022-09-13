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

/*
Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
*/


select concat(name,'(',left(occupation,1),')') from occupations
order by name asc;

select concat('There are a total of ', count(occupation), ' ', lower(occupation),'s.') from occupations
group by occupation
order by count(occupation), lower(occupation);

/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.
*/


SET @d = 0, @p = 0, @s = 0, @a = 0;
SELECT MIN(DOCTOR_NAMES), MIN(PROFESSOR_NAMES), MIN(SINGER_NAMES), MIN(ACTOR_NAMES)
FROM
  (
    SELECT
      CASE WHEN OCCUPATION = 'Doctor' THEN NAME END AS DOCTOR_NAMES,
      CASE WHEN OCCUPATION = 'Professor' THEN NAME END AS PROFESSOR_NAMES,
      CASE WHEN OCCUPATION = 'Singer' THEN NAME END AS SINGER_NAMES,
      CASE WHEN OCCUPATION = 'Actor' THEN NAME END AS ACTOR_NAMES,
      CASE
        WHEN OCCUPATION = 'Doctor' THEN (@d := @d + 1)
        WHEN OCCUPATION = 'Professor' THEN (@p := @p + 1)
        WHEN OCCUPATION = 'Singer' THEN (@s := @s + 1)
        WHEN OCCUPATION = 'Actor' THEN (@a := @a + 1)
      END AS ROW_NUM
    FROM OCCUPATIONS
    ORDER BY NAME
  ) AS TEMP
GROUP BY ROW_NUM;

/*
Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.
*/

select s.name from students s 
join friends f on s.id = f.id
join packages p on f.id = p.id
join packages p2 on p2.id = f.friend_id
where p.salary < p2.salary
order by p2.salary;        

/*
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
*/

select f.X, f.Y from functions f
where f.X = f.Y and (select count(*) from functions where X = f.X and Y = f.Y)>1
union
select f.X, f.Y from functions f
where exists(select X,Y from functions where f.Y = X and f.X = Y and f.X < X)
order by X;

/*
Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

The query result format is in the following example.
*/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
RETURN(
select distinct salary from 
(select salary, dense_rank() over (order by salary desc) as r from employee) e
    where r = N
  );
END

