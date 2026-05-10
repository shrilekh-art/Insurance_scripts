use insurance_db ;

desc customers;
select * from customers where phone is null or email is null ; 

desc policies ;
select * from policies where status is null or premium_amount is null;

-- Claims with missing claim status

SELECT *
FROM claims
WHERE claim_status IS NULL;

