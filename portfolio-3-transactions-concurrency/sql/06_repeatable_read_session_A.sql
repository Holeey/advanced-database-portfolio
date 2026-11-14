-- REPEATABLE READ: Session A
-- Keep this transaction open while Session B runs its update and COMMIT.
BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT account_id, account_name, balance
FROM transaction_demo
WHERE account_id = 1;

-- After Session B commits, run this same SELECT again.
-- It should continue to show the transaction's original snapshot.
SELECT account_id, account_name, balance
FROM transaction_demo
WHERE account_id = 1;

COMMIT;

-- Outside the transaction, a new statement sees the latest committed value.
SELECT account_id, account_name, balance
FROM transaction_demo
WHERE account_id = 1;
