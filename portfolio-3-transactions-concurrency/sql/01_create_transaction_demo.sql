-- Portfolio 3: transaction demonstration table
-- Run once in clinix_hospital_db.
CREATE TABLE IF NOT EXISTS transaction_demo (
    account_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_name VARCHAR(50) NOT NULL UNIQUE,
    balance NUMERIC(12,2) NOT NULL CHECK (balance >= 0)
);

-- Insert the demonstration accounts only if they do not already exist.
INSERT INTO transaction_demo (account_name, balance)
VALUES ('Demo Account A', 1000.00), ('Demo Account B', 1500.00)
ON CONFLICT (account_name) DO NOTHING;

SELECT account_id, account_name, balance
FROM transaction_demo
ORDER BY account_id;
