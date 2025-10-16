-- Configure PostgreSQL query logging
-- This enables logging for security and debugging purposes

-- NOTE: pg_stat_statements extension is installed in init-users.sql (requires superuser)
-- IMPORTANT: To use pg_stat_statements, PostgreSQL must be started with:
--   shared_preload_libraries = 'pg_stat_statements'
-- This can be set via:
--   1. Docker: Add command option -c shared_preload_libraries=pg_stat_statements
--   2. postgresql.conf: shared_preload_libraries = 'pg_stat_statements'
--   3. ALTER SYSTEM: ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements'; (requires restart)
--
-- The audit.query_stats view will only work after this configuration and database restart.

-- PostgreSQL logging configuration notes:
-- The following settings should be configured in postgresql.conf or via ALTER SYSTEM
-- They require superuser privileges to change
--
-- Recommended settings for production:
--
-- log_statement = 'mod'              -- Log all data-modifying statements (INSERT/UPDATE/DELETE)
-- log_duration = on                   -- Log duration of each completed statement
-- log_min_duration_statement = 500   -- Log queries taking longer than 500ms
-- log_line_prefix = '%t [%p] %u@%d %a ' -- Format: timestamp [pid] user@database application_name
-- log_connections = on                -- Log all connection attempts
-- log_disconnections = on             -- Log session terminations
-- log_lock_waits = on                 -- Log long lock waits
-- log_checkpoints = on                -- Log checkpoint activity
--
-- pg_stat_statements configuration:
-- shared_preload_libraries = 'pg_stat_statements'
-- pg_stat_statements.track = 'all'   -- Track all statements
-- pg_stat_statements.max = 10000     -- Track up to 10000 distinct queries
--
-- See database/docs/QUERY_LOGGING.md for complete guide

-- Create view for easy access to query statistics
CREATE OR REPLACE VIEW audit.query_stats AS
SELECT
    userid::regrole::text AS user_name,
    dbid,
    query,
    calls,
    total_exec_time,
    mean_exec_time,
    max_exec_time,
    stddev_exec_time,
    rows,
    shared_blks_hit,
    shared_blks_read
FROM pg_stat_statements
ORDER BY total_exec_time DESC;

GRANT SELECT ON audit.query_stats TO portfolio_admin;
GRANT SELECT ON audit.query_stats TO portfolio_public;

COMMENT ON VIEW audit.query_stats IS 'Aggregated query performance statistics from pg_stat_statements';
