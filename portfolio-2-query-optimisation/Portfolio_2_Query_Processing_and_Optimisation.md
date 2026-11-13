# Portfolio 2: Query Processing and Optimisation

## 1. Introduction

This portfolio examines how PostgreSQL processes queries against the Clinix Diagnostics Hospital Management System database. The practical work demonstrates multi-table joins, filtering, sorting, aggregation, execution-plan analysis, and the use of a composite B-tree index.

The database contains a small set of fictional sample records. Consequently, the execution times are useful for demonstrating PostgreSQL query-planning behavior, but they should not be treated as a reliable large-scale performance benchmark.

## 2. Multi-table query with filtering and sorting

The following query retrieves scheduled appointments together with the relevant patient, doctor, and department information.

```sql
SELECT a.appointment_id, p.first_name || ' ' || p.last_name AS patient_name, doc.first_name || ' ' || doc.last_name AS doctor_name, d.department_name, a.appointment_date, a.appointment_time, a.appointment_status FROM appointments a INNER JOIN patients p ON a.patient_id = p.patient_id INNER JOIN doctors doc ON a.doctor_id = doc.doctor_id INNER JOIN departments d ON doc.department_id = d.department_id WHERE a.appointment_status = 'Scheduled' ORDER BY a.appointment_date, a.appointment_time;
```

The query returned two rows: John Okafor's appointment with James Okafor and Mary Adeyemi's appointment with Sarah Adeyemi. Both appointments were in the Cardiology department and had a status of `Scheduled`.

The query demonstrates `INNER JOIN` to combine related tables, `WHERE` to filter scheduled appointments, and `ORDER BY` to sort the results by appointment date and time.

## 3. Initial execution-plan analysis

The query was examined using PostgreSQL's `EXPLAIN (ANALYZE, BUFFERS)` command.

The initial plan included:
- Sequential scans on the `appointments`, `patients`, and `doctors` tables.
- Hash joins to match patient and doctor records with appointments.
- A nested loop to retrieve the related department records.
- An index scan using the departments primary-key index.
- A sort operation to order the final rows.

The initial execution time was 0.353 ms, and the planning time was 0.966 ms. Two rows were returned. Three appointment rows were removed by the status filter.

A sequential scan was reasonable for this demonstration because the tables contained only a few records. Reading a very small table directly can cost less than using an index.

## 4. Composite index creation and verification

A composite B-tree index was created on the appointment status, date, and time columns:

```sql
CREATE INDEX idx_appointments_status_date_time ON appointments (appointment_status, appointment_date, appointment_time);
```

The table statistics were then updated:

```sql
ANALYZE appointments;
```

The index was verified using:

```sql
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'appointments';
```

The query returned the `appointments_pkey` primary-key index and the new `idx_appointments_status_date_time` index.

The composite index is designed to support queries that filter by appointment status and retrieve matching appointments ordered by date and time.

## 5. Comparing the execution plan after index creation

The original multi-table query was executed again using `EXPLAIN (ANALYZE, BUFFERS)`.

PostgreSQL continued to use a sequential scan on `appointments` for that query. The reported execution time was 0.275 ms, compared with 0.353 ms before the index was created. However, the plan did not use the new composite index, and the database statistics had also been refreshed. Therefore, the small timing difference cannot be attributed to the index alone.

This result illustrates that creating an index does not guarantee that PostgreSQL will use it. The query planner estimates the cost of available execution strategies and selects the plan it considers appropriate.

## 6. Controlled demonstration of index usage

To demonstrate that the composite index could be used for a matching query, sequential scans were temporarily disabled for the current session:

```sql
SET enable_seqscan = OFF;
```

The following query was examined:

```sql
EXPLAIN (ANALYZE, BUFFERS) SELECT appointment_id, appointment_date, appointment_time FROM appointments WHERE appointment_status = 'Scheduled' ORDER BY appointment_date, appointment_time;
```

The execution plan reported:

`Index Scan using idx_appointments_status_date_time on appointments`

The plan returned two rows and reported an execution time of 0.257 ms. It did not contain a separate sort node because the index ordering was compatible with the query's filter and ordering columns.

This was a controlled demonstration: sequential scans had been disabled, so the result does not show that PostgreSQL would independently choose this index under normal settings. The normal planner behavior was restored with:

```sql
RESET enable_seqscan;
```

## 7. Aggregation query using LEFT JOIN

A second query was used to calculate the number of appointments associated with each department, including departments with no appointments:

```sql
SELECT d.department_name, COUNT(a.appointment_id) AS total_appointments FROM departments d LEFT JOIN doctors doc ON d.department_id = doc.department_id LEFT JOIN appointments a ON doc.doctor_id = a.doctor_id GROUP BY d.department_id, d.department_name ORDER BY total_appointments DESC, d.department_name;
```

The query returned all eight departments. Cardiology had two appointments; Neurology, Radiology, and Surgery had one appointment each; Emergency, Laboratory, Paediatrics, and Pharmacy had zero appointments.

The query demonstrates `LEFT JOIN`, `COUNT`, `GROUP BY`, and `ORDER BY`. The left joins preserve departments even when they have no matching doctor or appointment. `COUNT(a.appointment_id)` returns zero for those departments because it counts non-NULL appointment identifiers.

## 8. Aggregation query execution-plan analysis

The aggregation query was examined with `EXPLAIN (ANALYZE, BUFFERS)`.

The plan used:
- Sequential scans on `departments`, `doctors`, and `appointments`.
- Hash Left Joins to combine departments with doctors and appointments while preserving unmatched departments.
- `HashAggregate` to group the joined records and calculate appointment counts.
- A final sort to order the departments by appointment count and department name.

The plan showed 9 rows entering the aggregation stage and 8 grouped rows in the final result. The execution time was 0.339 ms, and the planning time was 0.518 ms.

The sequential scans are reasonable for the small sample tables. The plan also demonstrates how PostgreSQL can use hash-based joins and aggregation to process a grouped query.

## 9. Performance and optimisation discussion

The practical exercise demonstrates several important query-optimisation principles:

1. PostgreSQL uses a cost-based planner to choose among possible execution strategies.
2. Sequential scans can be appropriate for small tables; indexes are not automatically faster for every query.
3. A composite index can support filtering and ordering when its column order matches the query conditions.
4. An index can exist without being selected by the planner for a particular query.
5. Execution-plan evidence should be interpreted carefully. The controlled index demonstration used `SET enable_seqscan = OFF`, so it proves that the index is usable, not that PostgreSQL selected it under normal planning conditions.
6. The observed execution-time differences are very small and should not be presented as proof of a significant performance improvement. Larger and more representative data would be required for a meaningful benchmark.

## 10. Evidence to include

Add screenshots or captured terminal output showing:
- The scheduled-appointments query and its two returned rows.
- The initial execution plan for the multi-table query.
- Successful creation of the composite index and the `ANALYZE` command.
- The `pg_indexes` output showing the new index.
- The post-index execution plan for the multi-table query.
- The controlled index-scan execution plan.
- The department appointment-count query and its eight returned rows.
- The aggregation query execution plan.

## 11. Conclusion

The practical work demonstrated SQL query processing using joins, filtering, sorting, and aggregation. PostgreSQL execution plans were examined to identify sequential scans, hash joins, nested loops, index scans, aggregation, and sorting. A composite B-tree index was created, verified, and demonstrated through a controlled index-scan test. The results show that query optimisation depends on query structure, available indexes, table size, and the planner's cost estimates. The experiment also shows why execution-plan evidence and careful interpretation are important when evaluating database performance.

*Case-study note: This is an academic database simulation using fictional sample records.*
