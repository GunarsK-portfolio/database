-- Create partitioned action_log table in audit schema for tracking user actions
-- This table logs all significant user actions: logins, downloads, uploads, etc.
-- Uses monthly partitioning with automatic partition creation and 12-month retention via pg_partman

-- Create partman schema and enable pg_partman extension (if available)
CREATE SCHEMA IF NOT EXISTS partman;
-- Only create extension if pg_partman is installed (skipped in CI with stub functions)
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'pg_partman') THEN
        CREATE EXTENSION IF NOT EXISTS pg_partman SCHEMA partman;
    ELSE
        RAISE NOTICE 'pg_partman extension not available, using stub functions (CI mode)';
    END IF;
END $$;

-- Create sequence for ID (BIGSERIAL doesn't work with partitioned tables)
CREATE SEQUENCE audit.action_log_id_seq;

-- Create partitioned table
CREATE TABLE audit.action_log (
    id BIGINT NOT NULL DEFAULT nextval('audit.action_log_id_seq'),
    -- 'login', 'logout', 'download', 'upload', 'delete', etc.
    action_type VARCHAR(50) NOT NULL,
    -- 'file', 'user', NULL for non-resource actions
    resource_type VARCHAR(50),
    -- Reference to resource (file_id, user_id, etc.)
    resource_id BIGINT,
    -- NULL for anonymous actions (public downloads)
    user_id BIGINT,
    ip_address VARCHAR(45),             -- IPv4 or IPv6 address
    user_agent TEXT,                    -- Browser/client user agent
    -- Flexible field for action-specific data
    metadata JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
    PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

-- Create indexes on partitioned table
CREATE INDEX idx_action_log_type ON audit.action_log (action_type);
CREATE INDEX idx_action_log_resource ON audit.action_log (
    resource_type, resource_id
);
CREATE INDEX idx_action_log_user ON audit.action_log (user_id);
CREATE INDEX idx_action_log_created ON audit.action_log (created_at DESC);

-- Add table and column comments
COMMENT ON TABLE audit.action_log IS 'Partitioned table logging all user actions. Partitioned by month with automatic partition creation and 12-month retention.';
COMMENT ON COLUMN audit.action_log.action_type IS 'Type of action performed (login, logout, download, upload, delete)';
COMMENT ON COLUMN audit.action_log.resource_type IS 'Type of resource affected (file, user, etc.)';
COMMENT ON COLUMN audit.action_log.resource_id IS 'ID of the affected resource';
COMMENT ON COLUMN audit.action_log.user_id IS 'User who performed the action (NULL for anonymous)';
COMMENT ON COLUMN audit.action_log.metadata IS 'Additional action-specific data in JSON format';

-- Grant permissions
GRANT SELECT, INSERT ON audit.action_log TO portfolio_admin;
GRANT USAGE, SELECT ON SEQUENCE audit.action_log_id_seq TO portfolio_admin;
GRANT SELECT, INSERT ON audit.action_log TO portfolio_public;
GRANT USAGE, SELECT ON SEQUENCE audit.action_log_id_seq TO portfolio_public;

-- ============================================================================
-- Automatic Partition Management with pg_partman
-- ============================================================================

-- Configure pg_partman for automatic partition management
-- Note: pg_partman v5+ only supports native partitioning, p_type parameter is deprecated
-- p_premake creates future partitions: 1 = current + next month
SELECT partman.create_parent(
    p_parent_table := 'audit.action_log'::text,
    p_control := 'created_at'::text,
    p_interval := '1 month'::text,
    p_premake := 1,
    p_start_partition := to_char(current_date, 'YYYY-MM-01')::text
);

-- Configure retention policy (drop partitions older than 12 months)
UPDATE partman.part_config
SET
    retention = '12 months',
    retention_keep_table = false,  -- Drop old partitions completely
    retention_keep_index = false,
    infinite_time_partitions = true
WHERE parent_table = 'audit.action_log';

COMMENT ON TABLE partman.part_config IS 'pg_partman configuration - run partman.run_maintenance() periodically via cron to manage partitions';
