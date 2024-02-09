/*You have a table of in-app purchases by user. Users that make
their first in-app purchase are placed in a marketing campaign
where they see call-to-actions for more in-app purchases. Find
the number of users that made additional in-app purchases due
to the success of the marketing campaign.
The marketing campaign doesn't start until one day after the
initial in-app purchase so users that only made one or multiple
purchases on the first day do not count, nor do we count users
that over time purchase only the products they purchased on the
first day.
Table: Marketing Campaign*/
select count(distinct user_id) from
(select user_id, created_at,
dense_rank()over (partition by user_id order by created_at) date_rnk,
dense_rank()over (partition by user_id,product_id order by created_at) product_rnk
from marketing_campaign)t1
where date_rnk>1 and product_rnk=1;

/*Find the top 5 states with the most 5 star businesses. Output the state name along with the 
number of 5-star businesses and order records by the number of 5-star businesses in descending order. In case there are ties in the number of businesses, return all the unique states. 
If two states have the same result, sort them in alphabetical order. Table: Yelp Business*/
select state, numbers, drank from
(select state,count(stars) as numbers,
dense_rank() over ( order by count(stars) desc) drank
from yelp_business
where stars=5
group by state)t1
where drank<=5;

/*Find matching hosts and guests pairs in a way that they are both of the same gender and 
nationality. Output the host id and the guest id of matched pair.*/
select distinct host_id,ah.nationality, ag.gender,guest_id from airbnb_hosts ah
join airbnb_guests ag
where ah.nationality=ag.nationality
and ah.gender=ag.gender;

/*Find libraries who haven't provided the email address in circulation year 2016 but their 
notice preference definition is set to email*/
select notice_preference_definition,provided_email_address,year_patron_registered 
from library_usage
where year_patron_registered='2016'
and notice_preference_definition='email'
having provided_email_address=1;

/*Find the highest target achieved by the employee or employees who works under the manager id 
13. Output the first name of the employee and target achieved. The solution should show 
the highest target achieved under Manager id is 13 and which employee(s) achieved it*/
select first_name, target,manager_id from sf_employee
where manager_id=13
order by target desc limit 1;


select sf.first_name, sf.target, sf.manager_id
from sf_employee sf join(
select max(target) as max_target,manager_id from sf_employee
where manager_id=13
group by manager_id)tbl
on sf.target=tbl.max_target
and sf.manager_id=tbl.manager_id;

/*Find the average total compensation based on employee titles and gender. Total compensation is 
calculated by adding both the salary and bonus of each employee. However, not every employee
 receives a bonus so disregard employees without bonus*/

select tbl.*,avg(total) from sf_employee sfee join
(select employee_title,sum(salary)+sum(bonus) as total
from sf_employee sfe
inner join sf_bonus sfb
on sfe.id=sfb.worker_ref_id
where bonus<>0
group by employee_title)tbl 
on sfee.employee_title=tbl.employee_title
group by sfee.employee_title,sfee.sex;

/*Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. The output should be sorted by earliest date first and contain 3 columns date, nonpaying downloads, paying*/
with tbl as
(select mdf.download_date,
  sum(case when paying_customer='no' then downloads End)  as non_paying_downloads,
  sum(case when paying_customer='yes' then downloads End) as paying
  from ms_user_dimension mud
join ms_acc_dimension mad
on mud.acc_id=mad.acc_id
join ms_download_facts mdf
on mud.user_id=mdf.user_id
Group by download_date
order by download_date)
select * from tbl
where tbl.non_paying_downloads>tbl.paying;

/*What is the overall friend acceptance rate by date? Your output should have the rate of 
acceptances by the date the request was sent. Order by the earliest date to latest. Assume that 
each friend request starts by a user sending (i.e., user_id_sender) a friend request to another 
user (i.e., user_id_receiver) that's logged in the table with action = 'sent'. If the request 
is accepted, the table logs action = 'accepted'.
If the request is not accepted, no record of action=’accepted’ is logged.*/
select accepted.request_date,count(accepted.user_id_receiver)/count(sent.user_id_sender) from 
(
select user_id_sender,user_id_receiver,request_date,action
from fb_friend_request
where action='sent') sent
left join
(select user_id_sender,user_id_receiver,request_date,action
from fb_friend_request
where action='accepted') accepted
on sent.user_id_sender= accepted.user_id_sender
and sent.user_id_receiver= accepted.user_id_receiver
Group by accepted.request_date
order by accepted.request_date;