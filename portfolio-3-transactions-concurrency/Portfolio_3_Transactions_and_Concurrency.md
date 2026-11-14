# Portfolio 3: Transactions and Concurrency

## Project
**Advanced Database Design, Implementation and Optimisation for Clinix Diagnostics Hospital Management System (CDHMS)**

**Database:** `clinix_hospital_db`  
**DBMS:** PostgreSQL 18.6  
**Demonstration table:** `transaction_demo`

## 1. Aim
This portfolio demonstrates transaction processing and concurrency behavior in PostgreSQL using two fictional bank-style demonstration accounts. The table is an isolated teaching example and is not part of the hospital's patient or clinical records.

## 2. Transaction demonstration table
The `transaction_demo` table contains:
- `account_id`: identity primary key.
- `account_name`: unique, required account label.
- `balance`: required numeric balance with a CHECK constraint preventing negative values.

The two demonstration rows were:
- Demo Account A (`account_id = 1`)
- Demo Account B (`account_id = 2`)

## 3. COMMIT
A transaction transferred 200.00 from Demo Account A to Demo Account B. The two balance updates were performed between `BEGIN` and `COMMIT`.

The observed balances inside the transaction and after commit were:
- Account A: 800.00
- Account B: 1700.00

**Interpretation:** `COMMIT` makes the transaction's changes permanent and visible to subsequent transactions. The paired debit and credit illustrate keeping related changes within one transaction.

## 4. ROLLBACK
A separate transaction temporarily reduced Account A by 300.00. A query inside the transaction showed Account A at 500.00. The transaction was then rolled back.

After `ROLLBACK`, the observed balances returned to:
- Account A: 800.00
- Account B: 1700.00

**Interpretation:** `ROLLBACK` cancels the uncommitted changes made by the current transaction.

## 5. Concurrent sessions
Two separate SQL Shell connections were used. PostgreSQL backend process IDs confirmed that the sessions were independent:
- Session A: PID `27340`
- Session B: PID `31204`

This matters because concurrency behavior must be tested across separate database sessions, not by issuing both sessions' commands in one connection.

## 6. READ COMMITTED experiment
The experiment began with Account A at 800.00.

1. Session A started a `READ COMMITTED` transaction and read Account A.
2. Session B increased Account A by 50.00 and committed.
3. Session A repeated the SELECT and observed 850.00.

**Observed result:** Session A's later statement saw the newly committed value.

**Interpretation:** PostgreSQL's `READ COMMITTED` isolation level takes a fresh snapshot for each statement. A repeated query can therefore return a different committed value if another transaction changes and commits the row between the two statements. This is an example of a non-repeatable read.

## 7. REPEATABLE READ experiment
The experiment began with Account A at 850.00.

1. Session A started a `REPEATABLE READ` transaction and read Account A as 850.00.
2. Session B increased Account A by 50.00 and committed, making the committed value 900.00.
3. Session A repeated the SELECT while its transaction remained open and still observed 850.00.
4. Session A committed and then queried again, observing 900.00.

**Observed result:** The second read inside Session A remained at 850.00; after the transaction ended, a new query saw 900.00.

**Interpretation:** PostgreSQL's `REPEATABLE READ` uses a transaction-level snapshot for ordinary reads. Changes committed by another transaction after that snapshot was established are not visible to the current transaction's subsequent reads.

## 8. Comparison

| Feature | READ COMMITTED | REPEATABLE READ |
|---|---|---|
| Snapshot behavior | New snapshot for each statement | Consistent transaction snapshot |
| Can a repeated SELECT see a later committed update? | Yes | No, not within the same transaction |
| Non-repeatable read | Possible | Prevented |

## 9. ACID properties in the demonstration
- **Atomicity:** The two balance changes in the transfer were grouped into one transaction; a transaction can be rolled back rather than leaving only part of the intended work.
- **Consistency:** The `CHECK (balance >= 0)` constraint protects the balance rule, and the primary key/unique account name constraints protect row identity.
- **Isolation:** The two-session experiments showed how isolation levels control visibility of concurrent commits.
- **Durability:** After `COMMIT`, the changes were visible to later queries.

## 10. Conclusion
The PostgreSQL exercises demonstrated transaction boundaries through `COMMIT` and `ROLLBACK`, and compared the visibility rules of `READ COMMITTED` and `REPEATABLE READ` using two independent sessions. The experiments show why transaction isolation is important when multiple users or application processes access and modify shared data.

## 11. Evidence
Screenshots are stored in `evidence/Screenshots/`. They document the COMMIT and ROLLBACK demonstrations, the two independent backend PIDs, and the READ COMMITTED and REPEATABLE READ experiments.

## 12. Reproducibility
The SQL scripts in `sql/` provide the table setup, transaction demonstrations, separate Session A and Session B commands for both isolation experiments, and a final verification query. Run the Session A and Session B scripts in separate SQL Shell connections where indicated.

**Note:** The `transaction_demo` table is a teaching aid for transaction/concurrency experiments. It is not a production banking module and does not represent real patient information.
