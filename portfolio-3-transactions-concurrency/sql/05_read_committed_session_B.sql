-- READ COMMITTED: Session B
-- Run while Session A's READ COMMITTED transaction remains open.
BEGIN;
UPDATE transaction_demo
SET balance = balance + 50.00
WHERE account_id = 1;
COMMIT;
SELECT account_id, account_name, balance
FROM transaction_demo
WHERE account_id = 1;
