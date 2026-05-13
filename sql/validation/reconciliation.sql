USE insurance_db;

-- =====================================================
-- TASK 5.5
-- Premium vs Payment reconciliation
-- =====================================================

SELECT
    p.policy_id,
    p.premium_amount,
    COALESCE(SUM(pay.amount),0) AS total_payment,
    p.premium_amount -
    COALESCE(SUM(pay.amount),0) AS difference
FROM policies p
LEFT JOIN payments pay
       ON p.policy_id = pay.policy_id
GROUP BY
    p.policy_id,
    p.premium_amount;
    
-- =====================================================
-- TASK 5.6
-- Business rule validations
-- =====================================================

-- Negative premium

SELECT *
FROM policies
WHERE premium_amount < 0;

-- Invalid policy dates

SELECT *
FROM policies
WHERE end_date < start_date;

-- Negative claim amount

SELECT *
FROM claims
WHERE claim_amount < 0;    