/*We have a table with employees and their salaries, however, some of the records are old and 
contain outdated salary information. Find the current salary of each employee assuming that 
salaries increase each year. Output their id, first name, last name, department ID, and 
current salary. Order your list by employee ID in ascending order.*/
select mes.id, first_name,salary, last_name, department_id
from ms_employee_salary mes
inner join
(select id, max(salary) as mxsaalry
from ms_employee_salary
group by id) as med
on med.id=mes.id
where salary=med.mxsaalry
order by id;



/*Find order details made by Jill and Eva. Consider the Jill and Eva as first names of customers. Output the order date, details and cost along with the first name. 
Order records based on the customer id in ascending order.*/
select  cust_id, order_date, order_details, total_order_cost,first_name from orders o
join customer c
on o.cust_id=c.id
where first_name in('Eva','Jill')
order by cust_id;
/*Find the details of each customer regardless of whether the customer made an order. Output the 
customer's first name, last name, and the city along with the order details. You may have 
duplicate rows in your results due to a customer ordering several of the same items. 
Sort records based on the customer's first name and the order details in ascending order.*/
select first_name,last_name,city,order_details,total_order_cost from orders o
right join customer c
on c.id=o.id
order by first_name , order_details;


/*Airbnb Find the number of apartments per nationality that are owned by people under 30 years 
old. Output the nationality along with the number of apartments.
Sort records by the apartments count in descending order*/
select count(distinct unit_id), nationality from airbnb_units au
join  airbnb_hosts ah
on ah.host_id=au.host_id
where ah.age<30
and  au.unit_type='apartment'
group by nationality
order by count(distinct unit_id);

/*Meta/Facebook has developed a new programming familiarity as well as the number of years of
experience, age, gender and most importantly satisfaction with
Hack. Due to an error location data was not collected, but your
supervisor demands a report showing average popularity of Hack
by office location.
Luckily the user IDs of employees completing the surveys were
stored. Based on the above, find the average popularity of the
Hack per office location. Output the location along with the
average popularity.*/
select fe.location,avg(fhs.popularity) from facebook_hack_survey fhs 
join 
facebook_employees fe
on fe.employee_id=fhs.employee_id
group by fe.location;