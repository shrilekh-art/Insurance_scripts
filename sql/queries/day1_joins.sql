select * from customers;
select * from policies ;
select * from payments ;
select * from agents ; 

-- TASK1 :Which customer owns which policy and which agent sold it?
-- customers -> policies -> agents 

select c.first_name , c.last_name , p.policy_id , p.policy_type,a.agent_name from customers c 
inner join policies p
on c.customer_id = p.customer_id
inner join agents a
on p.agent_id = a.agent_id ;

-- Task 2 : Show all registered customers even if they never purchased policy
select c.first_name , c.last_name , p.policy_id  from customers c 
left join policies p
on c.customer_id = p.customer_id
where p.customer_id is null; 

-- TASK 2.3 — POLICIES WITHOUT PAYMENTS 
-- Which issued policies are unpaid?
select * from policies po
left join payments py
on po.policy_id = py.policy_id 
where py.policy_id is null ; 

 
-- TASK 2.4 — CUSTOMERS WITH MULTIPLE POLICIES
select c.customer_id,c.first_name,c.last_name,p.policy_id,count(*) as customers_with_multiple_policies
 from customers c
inner join policies p
on c.customer_id = p.customer_id
group by c.customer_id,c.first_name,c.last_name,p.policy_id
having count(*) > 1 ; 

-- TASK 3 — ON vs WHERE 
-- Task 3.1- Show all customers and their ACTIVE policies 
-- Even customers without active policy should appear

-- =====================================================
-- TASK 3A
-- WRONG: WHERE destroys LEFT JOIN
-- =====================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.policy_id,
    p.status
FROM customers c
LEFT JOIN policies p
       ON c.customer_id = p.customer_id
WHERE p.status = 'ACTIVE';

-- =====================================================
-- TASK 3B
-- CORRECT: filter inside ON
-- =====================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.policy_id,
    p.status
FROM customers c
LEFT JOIN policies p
       ON c.customer_id = p.customer_id
      AND p.status = 'ACTIVE';
      
-- TASK 4 — DUPLICATE EXPLOSION       
-- TASK 4.1 — CREATE EXPLOSION -> Show customer policies and claims
-- =====================================================
-- TASK 4.1
-- Duplicate explosion scenario
-- =====================================================
select * from customers ;
select * from policies;
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.policy_id,
    cl.claim_id,
    cl.claim_amount
FROM customers c
INNER JOIN policies p
        ON c.customer_id = p.customer_id
INNER JOIN claims cl
        ON p.policy_id = cl.policy_id;


-- =====================================================
-- TASK 4.2
-- WRONG aggregation due to join explosion
-- =====================================================

SELECT
    SUM(p.premium_amount) AS total_premium
FROM customers c
INNER JOIN policies p
        ON c.customer_id = p.customer_id
INNER JOIN claims cl
        ON p.policy_id = cl.policy_id;


-- =====================================================
-- TASK 4.3
-- DISTINCT misuse
-- =====================================================

SELECT DISTINCT
    c.customer_id,
    p.policy_id
FROM customers c
INNER JOIN policies p
        ON c.customer_id = p.customer_id
INNER JOIN claims cl
        ON p.policy_id = cl.policy_id;
        
        
-- =====================================================
-- TASK 4.4
-- Correct aggregation approach Aggregate child before joining
-- =====================================================

SELECT
    p.policy_id,
    p.premium_amount,
    COUNT(cl.claim_id) AS total_claims
FROM policies p
LEFT JOIN claims cl
       ON p.policy_id = cl.policy_id
GROUP BY
    p.policy_id,
    p.premium_amount;        
    
    -- =====================================================
-- TASK 4.5
-- Count distinct customers
-- =====================================================

SELECT
    COUNT(DISTINCT c.customer_id) AS unique_customers
FROM customers c
INNER JOIN policies p
        ON c.customer_id = p.customer_id
INNER JOIN claims cl
        ON p.policy_id = cl.policy_id;

