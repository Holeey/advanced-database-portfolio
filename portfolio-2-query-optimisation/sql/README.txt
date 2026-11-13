PORTFOLIO 2 - SQL SCRIPT DOCUMENTATION

Database: clinix_hospital_db
DBMS: PostgreSQL

These scripts document the SQL queries and execution-plan tests performed for Portfolio 2.

Run them individually in SQL Shell (psql) after connecting to the database:
    \c clinix_hospital_db

Recommended order:
01_scheduled_appointments.sql
02_initial_execution_plan.sql
03_create_composite_index.sql
04_verify_index.sql
05_post_index_execution_plan.sql
06_controlled_index_scan.sql
07_department_appointment_counts.sql
08_aggregation_execution_plan.sql

Important:
- The scripts are provided as documentation and for reproducibility.
- Script 03 uses CREATE INDEX IF NOT EXISTS so it can be safely rerun when the index already exists.
- Script 06 temporarily sets enable_seqscan to OFF only to demonstrate that the composite index can be used. It resets the setting at the end. This is not a recommendation to disable sequential scans in normal database operation.
- PostgreSQL selected sequential scans for the original multi-table query under normal planner settings because the sample tables are very small.
- Keep the execution-plan screenshots in the sibling evidence folder.
