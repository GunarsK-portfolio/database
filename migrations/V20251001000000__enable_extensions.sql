-- Enable required PostgreSQL extensions
-- This migration must run first (timestamp: 20251001000000)

-- pg_stat_statements: Query performance statistics
-- Requires: shared_preload_libraries = 'pg_stat_statements' in Aurora parameter group
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- pg_cron: Job scheduler for PostgreSQL
-- Required for automatic partition maintenance
-- Note: Available in Aurora PostgreSQL, auto-loaded
CREATE EXTENSION IF NOT EXISTS pg_cron;

COMMENT ON EXTENSION pg_stat_statements IS 'Track execution statistics of all SQL statements executed';
COMMENT ON EXTENSION pg_cron IS 'Job scheduler for running periodic tasks';
