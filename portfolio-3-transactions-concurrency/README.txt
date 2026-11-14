Portfolio 3 - Transactions and Concurrency

Contents:
- Portfolio_3_Transactions_and_Concurrency.md: report and interpretation
- sql/: SQL scripts for COMMIT, ROLLBACK, READ COMMITTED and REPEATABLE READ
- evidence/Screenshots/: place the renamed screenshots here

For the concurrency experiments, use two separate SQL Shell windows:
Session A scripts: 04_read_committed_session_A.sql and 06_repeatable_read_session_A.sql
Session B scripts: 05_read_committed_session_B.sql and 07_repeatable_read_session_B.sql

Important: The scripts are provided as reproducible documentation. Follow the Session A / Session B timing instructions in the comments; do not execute both session scripts in the same connection.
