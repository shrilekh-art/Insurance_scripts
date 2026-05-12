use insurance_db ;

-- Find records in A not present in B
-- policies without payments 

select * from policies ;
select * from payments ;  

select p.* from policies p 
left join payments pay
on p.policy_id = pay.policy_id 
where pay.policy_id is null ; 


-- Policies without claims

select  * from policies ; 
select * from claims ; 

select p.* from policies p 
left join claims c 
on p.policy_id = c.policy_id 
where c.policy_id is null ;


