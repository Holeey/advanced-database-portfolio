-- Verify the indexes defined on the appointments table.
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'appointments';
