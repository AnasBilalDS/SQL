/* Count the number of user events performed byMacBook pro users.
Output the result along with the event name. Sort
result based on the event count in desc order*/

select event_name, device,count(user_id) as "Event Count"from playbook_events
where device='macbook pro'
group by event_name
order by "Event Count" desc;

select sfe.first_name,sfe.employee_title, sfe.sex,sum(distinct sfe.salary)+sum(sbf.bonus) as total 
from sf_employee sfe
join sf_bonus sbf
on sfe.id=sbf.worker_ref_id
group by sfe.first_name,sfe.employee_title,sfe.sex;
===================================================
with total_sal as
(select sfe.first_name,sfe.employee_title,sfe.sex,sum(salary)+sum(bonus) as Total from sf_employee sfe
join sf_bonus sbf
on sfe.id=sbf.worker_ref_id
group by sfe.first_name,sfe.employee_title,sfe.sex)
select sf.first_name,avg(total) from total_sal ts
inner join sf_employee sf
on sf.first_name=ts.first_name
group by sf.first_name;

/*List all companies working in the financial sector with headquarters in Europe or Asia.*/
select company, sector, continent from forbes_1
where continent ='Asia'
or  continent='Europe'
having sector='Financials';

/*Count the number of companies in the Information Technology 
sector in each country.
Output the result along with the corresponding country name.
Order the result based on the number of companies in the 
descending order*/
select count(company) as count,sector,country from forbes_1
where sector=  'Information Technology'
group by country
order by count desc;

/*Find the 3 most profitable companies in the entire world. Output the result along with the corresponding company name. 
Sort the result based on profits in descending order.select company, profits from forbes_1
order by profits desc limit 3;*/
select company, profits from forbes_1
order by profits desc limit 3;

/*Find the most profitable company from the financial sector. 
Output the result along with the continent.*/
select profits, sector, continent from forbes_1
where sector='Financials'
order by profits desc limit 1;