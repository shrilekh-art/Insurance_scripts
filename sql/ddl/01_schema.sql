-- ===============================
-- DATABASE
-- ===============================
CREATE DATABASE IF NOT EXISTS insurance_db;
USE insurance_db;

-- ===============================
-- CUSTOMERS
-- ===============================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- AGENTS
-- ===============================
CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    region VARCHAR(50)
);

-- ===============================
-- POLICIES
-- ===============================
CREATE TABLE policies (
    policy_id INT PRIMARY KEY,
    customer_id INT,
    agent_id INT,
    policy_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    premium_amount DECIMAL(12,2),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

-- ===============================
-- PAYMENTS
-- ===============================
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    policy_id INT,
    payment_date DATE,
    amount DECIMAL(12,2),
    payment_mode VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

-- ===============================
-- CLAIMS
-- ===============================
CREATE TABLE claims (
    claim_id INT PRIMARY KEY,
    policy_id INT,
    claim_date DATE,
    claim_amount DECIMAL(12,2),
    claim_status VARCHAR(20),
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

-- ===============================
-- CLAIM TRANSACTIONS (EVENT-LEVEL)
-- ===============================
CREATE TABLE claim_transactions (
    txn_id INT PRIMARY KEY,
    claim_id INT,
    txn_date DATE,
    txn_type VARCHAR(50), -- CREATED / APPROVED / PAID
    amount DECIMAL(12,2),
    FOREIGN KEY (claim_id) REFERENCES claims(claim_id)
);

-- ===============================
-- SCD TABLE (POLICY HISTORY)
-- ===============================
CREATE TABLE policy_history (
    policy_hist_id INT PRIMARY KEY,
    policy_id INT,
    effective_start_date DATE,
    effective_end_date DATE,
    premium_amount DECIMAL(12,2),
    status VARCHAR(20),
    is_current BOOLEAN,
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

-- ===============================
-- ETL LOGGER TABLES
-- ===============================
CREATE TABLE etl_job_log (
    job_id INT PRIMARY KEY,
    job_name VARCHAR(100),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    status VARCHAR(20),
    records_processed INT,
    records_failed INT,
    error_message TEXT
);

CREATE TABLE etl_step_log (
    step_id INT PRIMARY KEY,
    job_id INT,
    step_name VARCHAR(100),
    step_start_time TIMESTAMP,
    step_end_time TIMESTAMP,
    status VARCHAR(20),
    rows_read INT,
    rows_written INT,
    error_message TEXT
);

CREATE TABLE data_validation_log (
    validation_id INT PRIMARY KEY,
    table_name VARCHAR(100),
    validation_type VARCHAR(50),
    expected_value VARCHAR(50),
    actual_value VARCHAR(50),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);