use insurance_db;

desc customers;

select * from customers ; 

-- business rule -> first_name , last_name , dob -> if same then likely to be duplicate 
select first_name , last_name , dob ,count(*) as duplicate_customers from customers 
group by first_name , last_name , dob Having count(*) > 1 ; 

