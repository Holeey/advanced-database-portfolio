# Portfolio 5 – Screenshot Evidence Index

The following screenshots document the successful PostgreSQL 18 streaming replication test for the Clinix Diagnostics Hospital Management System (CDHMS).

1. **P5_01_Standby_Recovery_Status.png** – Query executed against standby port 5433; `pg_is_in_recovery()` returned `t`, confirming the instance is in recovery/standby mode.
2. **P5_02_Streaming_Replication_Status.png** – Query executed against primary port 5432; `pg_stat_replication` reported client `127.0.0.1`, state `streaming`, and synchronization mode `async`.
3. **P5_03_Replicated_Data_Verification.png** – Query executed against standby port 5433; the row inserted on the primary appeared on the standby.

These are direct screenshots of the user's PowerShell session. The demonstration uses two PostgreSQL instances on one physical computer, not two separate physical servers.
