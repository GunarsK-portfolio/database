-- Schedule automatic partition maintenance using pg_cron
-- This ensures pg_partman creates future partitions and drops old ones automatically
-- Note: pg_cron extension is created in init script (requires superuser)

-- Schedule daily partition maintenance at 00:05 AM
-- This will create future partitions and drop old ones according to retention policy
SELECT cron.schedule(
    'partman-maintenance',           -- Job name
    '5 0 * * *',                     -- Cron schedule: daily at 00:05
    $$SELECT partman.run_maintenance();$$  -- SQL command to run
);
