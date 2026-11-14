-- READ COMMITTED: Session A
-- Keep this transaction open while Session B runs its update and COMMIT.
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT account_id, account_name, balance
FROM transaction_demo
WHERE account_id = 1;

-- After Session B commits, run the same SELECT again.
-- Under READ COMMITTED, a new statement can see the newly committed value.
SELECT account_id, account_name, balance
FROM transaction_demo
WHERE account_id = 1;

COMMIT;
