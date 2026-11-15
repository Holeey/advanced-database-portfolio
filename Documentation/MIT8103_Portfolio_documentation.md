# MIT 8103 – Advanced Database Systems: Individual Practical Portfolio
**Case study:** Clinix Diagnostics Hospital Management System (CDHMS) 
**Author:** Izuchukwu Samuel Odoh 
**e-mail:** i.odoh31078@miva.edu.ng 
**Student:** 301931078 | **Cohort:** September 2026

## 1. Overview
This individual portfolio developed and tested database concepts using a simulated hospital management system. PostgreSQL was used for the relational exercises and MongoDB for the document-oriented exercise. Only fictional academic records were used.

## 2. Portfolio activities and outcomes
- **Portfolio 1 – Database Design and Modelling:** Designed the relational data model and ERD, considered normalisation, created departments, doctors, patients and appointments tables, inserted sample records, and demonstrated joins.
- **Portfolio 2 – Query Processing and Optimisation:** Implemented filtering, sorting, joins and aggregation. Used EXPLAIN/EXPLAIN ANALYZE and indexing exercises to examine query execution.
- **Portfolio 3 – Transactions and Concurrency:** Demonstrated COMMIT and ROLLBACK and compared READ COMMITTED with REPEATABLE READ using two database sessions.
- **Portfolio 4 – NoSQL and Advanced Data Models:** Created MongoDB database `clinix_nosql` and `patients` collection with embedded appointments; performed retrieval, update, count and aggregation operations.
- **Portfolio 5 – Distributed and Cloud Database Exercise:** Configured PostgreSQL 18 streaming replication between two instances on one Windows computer: primary port 5432 and standby port 5433. `pg_is_in_recovery()` returned true on the standby, the primary reported `state=streaming` and `sync_state=async`, and a test row inserted on the primary was successfully read from the standby. Multi-site cloud deployment and sharding were evaluated as proposed extensions, not deployed.

## 3. Technical reflection
The work showed that relational design, query planning, transaction isolation, document modelling and replication address different requirements. A relational model supports structured constraints and transactional consistency, while embedded documents can represent nested appointment histories. The replication test demonstrated that a standby can receive and apply changes from a primary. However, both instances ran on one computer, so this setup does not protect against failure of that computer. A production design would require separate hosts or availability zones, monitored replication lag, tested failover, secure networking and independent backups. Replication is not a replacement for backup.

## 4. Repository and evidence
GitHub repository: https://github.com/Holeey/advanced-database-portfolio  
Confirm that the latest Portfolio 5 report, topology diagram, replication test results and this summary are committed and pushed. Add screenshots of the verification commands to the LMS submission.

## 5. AI-use declaration
ChatGPT was used to explain concepts, structure reports, suggest SQL and PostgreSQL configuration commands, and assist with troubleshooting. The student executed the commands, inspected outputs, tested primary-to-standby data transfer and reviewed the written material. The student should verify and edit the final submission for accuracy.

## 6. References
- PostgreSQL Global Development Group. PostgreSQL 18 Documentation. https://www.postgresql.org/docs/18/
- MongoDB, Inc. MongoDB Manual. https://www.mongodb.com/docs/manual/
- MIVA Open University. MIT 8103 Advanced Database Systems – Individual Practical Database Portfolio (September Cohort, 2026).
