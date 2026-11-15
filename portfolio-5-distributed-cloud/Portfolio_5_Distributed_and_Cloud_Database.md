# Portfolio 5: Distributed and Cloud Database Exercise
## Clinix Diagnostics Hospital Management System (CDHMS)

### 1. Case study and objective
This exercise extends the Clinix Diagnostics Hospital Management System (CDHMS), the academic hospital case study used throughout the database portfolio. The database supports patient, doctor, department and appointment records. The objective is to demonstrate how replication and distributed database concepts can support availability, read scalability and disaster recovery.

### 2. Implemented PostgreSQL streaming replication
A working PostgreSQL physical streaming-replication demonstration was configured using PostgreSQL 18 on Windows. Two separate PostgreSQL server instances ran on the same computer, using separate data directories and ports:
- **Primary:** port 5432, database `clinix_hospital_db`.
- **Standby:** port 5433, data directory `C:\Postgres\clinix_standby`.
- **Replication account:** `replicator`.
- **Replication mode:** asynchronous physical streaming replication using WAL.

The primary configuration included `listen_addresses='*'`, `wal_level=replica`, `max_wal_senders=10` and `max_replication_slots=10`. The host-based authentication configuration permitted the replication account to connect from the local loopback address. `pg_basebackup` created the standby copy and generated the standby recovery configuration. The standby was started on port 5433.

The standby role was verified using `SELECT pg_is_in_recovery();`, which returned `t`. The primary's `pg_stat_replication` view returned a connected client at `127.0.0.1`, state `streaming`, and synchronization mode `async`.

A test table named `replication_test` was created on the primary. One row containing the message **“Clinix streaming replication test successful”** was inserted on port 5432. The same row was then queried successfully from port 5433. This verifies that a committed change on the primary was received and applied by the standby.

**Important scope limitation:** both PostgreSQL instances ran on one physical computer. This is a valid local demonstration of PostgreSQL streaming replication between separate server instances, but it is not a geographically distributed or multi-machine cluster. It does not independently demonstrate hardware, site or network-failure resilience.

### 3. Proposed multi-site/cloud architecture
For a real multi-branch CDHMS deployment, the primary could run in a secured central cloud or data-centre environment, with one or more standby/read replicas in separate availability zones or locations. Application writes and consistency-critical reads should go to the primary. Reporting and other suitable read-only queries may be routed to replicas. The included topology diagram distinguishes the locally tested primary/standby pair from the broader proposed architecture.

### 4. Sharding, availability and consistency
If the hospital network expands and data volume requires horizontal distribution, records could be sharded by a stable key such as `hospital_id` or `branch_id`. Each shard would store records for a defined hospital or branch group. This is a proposed future strategy, not an implemented part of this practical. It requires shard-aware routing, cross-shard query handling and careful management of patient identity across branches. Sharding distributes data across database nodes; it is not the same as partitioning a table within one database.

Asynchronous replication improves read scalability and can provide a standby for recovery, but a replica may briefly lag behind the primary. Read-after-write operations and critical clinical transactions should therefore use the primary. A production design should define and test recovery-time and recovery-point objectives, monitor replication lag, document standby promotion, and maintain independent backups. Replication is not a substitute for backups because accidental changes may also be replicated.

### 5. Security and conclusion
A production deployment should use private networking, restricted firewall rules, encrypted connections, least-privilege accounts, managed secrets, encryption at rest, audit logging and tested backups. The demonstration uses fictional academic data only. The practical confirms that PostgreSQL 18 streaming replication can transfer committed changes from a primary instance to a standby instance. A true multi-site deployment, automated failover and sharding remain proposed extensions rather than completed tests.
