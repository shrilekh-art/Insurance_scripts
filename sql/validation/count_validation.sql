show tables;

select * from customers;
SELECT 'customers' as Table_Name ,
COUNT(*) as Total_Records 
From insurance_db.customers ;

select * from policies ;
select 'policies' , count(*) from insurance_db.policies;

select * from claims ;
select 'claims' ,count(*) from insurance_db.claims ;

select * from payments ; 
select 'payments', count(*) from insurance_db.payments;

select * from agents ;
select 'agents' , count(*) from insurance_db.agents ;

