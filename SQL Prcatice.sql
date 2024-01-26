/*Count the number of movies that Abigail Breslin was nominated for an oscar*/
select nominee,count(*) from oscar_nominees
where nominee='Russell Crowe';

select company, profits from forbes_1
order by profits desc limit 3;

/*Find the number of apartments per nationality that are owned by people under 30 years old.
Output the nationality along with the number of apartments.
Sort records by the apartments count in descending order*/
select unit_type,nationality, count(unit_type) as count,age from airbnb_units au
inner join airbnb_hosts ah
on ah.host_id=au.host_id 
where unit_type='Apartment'
group by unit_type,nationality,age
order by count desc ;

select ah.host_id,au.host_id,nationality, country,gender from airbnb_hosts ah
left join airbnb_units au
on au.host_id=ah.host_id
where au.host_id=ah.host_id
and ah.nationality=au.country;


/*Find libraries who haven't provided the email address in circulation year 2016 
but their notice preference definition is set to email*/
select circulation_active_year,notice_preference_definition,
provided_email_address from library_usage
where circulation_active_year=2016 and 
provided_email_address=0 and 
notice_preference_definition='email';


/*Find employees who are earning more than their managers*/
select * from employees e
join employees m
on e.manager_id= m.employee_id
and e.salary>m.salary;


/*Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order*/
select first_name,o.cust_id,o.order_date,o.total_order_cost from customer c
left outer join orders o
on o.id=c.id
where c.first_name in( 'Jill', 'Eva')
order by cust_id asc;

/*Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name, and the city along with the order details.
You may have duplicate rows in your results due to a customer ordering several of the same items. Sort records based on the customer's first name and the order details in ascending order*/
select concat(first_name,' ',last_name) as "Name",c.city,o.order_details from customer c
left outer join orders o
on c.id=o.id
union
select concat(first_name,' ',last_name) as "Name",c.city,o.order_details from customer c
right outer join orders o
on c.id=o.id
order by "name" asc, order_details asc;


/*Find the top 5 businesses with most reviews. Assume that each row has a unique business_id 
such that the total reviews for each business is listed on each row. Output the business name 
along with the total number of reviews and order your results by the total 
reviews in descending order*/
select business_name,review_count,
rank() over(order by review_count desc) rnk
from yelp_business
rnk limit 5;

select * from (select business_name,review_count,
rank() over(order by review_count desc) rnk
from yelp_business)tbl
where rnk<=5;
/*Find the highest target achieved by the employee or employees who works under the 
manager id 13. Output the first name of the employee and target achieved. 
The solution should show the highest target achieved under manager_id=13 
and which employee(s) achieved it.*/
select first_name, target
from sf_employee
where manager_id = 13
and target = 
(select max(target) 
 from sf_employee
 where manager_id = 13);
 
 select first_name, target
from sf_employee
where manager_id = 13
and target in
(select max(target) 
 from sf_employee
 where manager_id = 13);
 
 select * from orders;
 
select cust_id,monthname(order_date) Monthname,sum(total_order_cost) TotalSum from orders
where monthname(order_date)='March'
group by cust_id,monthname(order_date)
order by TotalSum desc ;

/*Find the most profitable company from the financial sector. 
Output the result along with the continent*/
select company, sector,continent,profits from forbes_1
where sector='Financials'
order by profits desc limit 1;

select * from ms_employee_salary;

/*We have a table with employees and their salaries, however, some of the records are 
old and contain outdated salary information. Find the current salary of each employee 
assuming that salaries increase each year. Output their id, first name, last name, 
department ID, and current salary.Order your list by employee ID in ascending order.*/
select id,first_name, last_name,department_id,max(salary) from ms_employee_salary
group by id,first_name, last_name,department_id
order by id asc;