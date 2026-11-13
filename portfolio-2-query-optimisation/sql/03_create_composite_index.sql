-- Create a composite B-tree index for status filtering and date/time ordering.
-- IF NOT EXISTS allows this script to be rerun without a duplicate-index error.
CREATE INDEX IF NOT EXISTS idx_appointments_status_date_time ON appointments (appointment_status, appointment_date, appointment_time);
ANALYZE appointments;
