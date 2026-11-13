-- Controlled demonstration that the composite index can serve this query.
-- Sequential scans are disabled only for this session-level demonstration.
SET enable_seqscan = OFF;
EXPLAIN (ANALYZE, BUFFERS) SELECT appointment_id, appointment_date, appointment_time FROM appointments WHERE appointment_status = 'Scheduled' ORDER BY appointment_date, appointment_time;
-- Restore PostgreSQL's normal planner setting immediately afterward.
RESET enable_seqscan;
