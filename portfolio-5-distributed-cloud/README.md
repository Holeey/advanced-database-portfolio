# Portfolio 5 – Distributed and Cloud Database Exercise

Case study: Clinix Diagnostics Hospital Management System (academic simulation).

**Implementation completed:** PostgreSQL 18 physical streaming replication was tested between two server instances on the same Windows computer:
- Primary: `127.0.0.1:5432`
- Standby: `127.0.0.1:5433`
- Database: `clinix_hospital_db`

Verified results:
1. `SELECT pg_is_in_recovery();` on port 5433 returned `t`.
2. `pg_stat_replication` on port 5432 showed client `127.0.0.1`, state `streaming`, sync mode `async`.
3. A test row inserted on the primary was successfully queried on the standby.

**Scope:** this proves local instance-to-instance streaming replication, not a geographically distributed or multi-machine cluster. Sharding and multi-site cloud deployment are discussed as proposed extensions.

Contents:
- `Portfolio_5_Distributed_and_Cloud_Database.md` – practical report.
- `architecture/` – topology diagram.
- `scripts/` – reproducible setup and verification commands.
- `evidence/` – text record of the successful verification outputs; add terminal screenshots before final LMS upload if available.
