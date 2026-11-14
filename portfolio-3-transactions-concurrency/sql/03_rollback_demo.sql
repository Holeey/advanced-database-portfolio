-- ROLLBACK demonstration
-- Run in one SQL Shell session.
BEGIN;
UPDATE transaction_demo SET balance = balance - 300.00 WHERE account_id = 1;
SELECT account_id, account_name, balance FROM transaction_demo ORDER BY account_id;
ROLLBACK;
SELECT account_id, account_name, balance FROM transaction_demo ORDER BY account_id;
