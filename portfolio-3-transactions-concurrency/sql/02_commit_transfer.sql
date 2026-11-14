-- COMMIT demonstration
-- Run in one SQL Shell session.
BEGIN;
UPDATE transaction_demo SET balance = balance - 200.00 WHERE account_id = 1;
UPDATE transaction_demo SET balance = balance + 200.00 WHERE account_id = 2;
SELECT account_id, account_name, balance FROM transaction_demo ORDER BY account_id;
COMMIT;
SELECT account_id, account_name, balance FROM transaction_demo ORDER BY account_id;
