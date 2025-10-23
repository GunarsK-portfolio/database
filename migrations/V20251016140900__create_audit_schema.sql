-- Create audit schema for change tracking
CREATE SCHEMA IF NOT EXISTS audit;

COMMENT ON SCHEMA audit IS 'Audit trail for data changes - tracks who changed what and when';

-- Grant permissions to portfolio_owner (for migrations)
GRANT ALL PRIVILEGES ON SCHEMA audit TO portfolio_owner;

-- Grant permissions to portfolio_admin (for writing audit logs via triggers)
GRANT USAGE ON SCHEMA audit TO portfolio_admin;
GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA audit TO portfolio_admin;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA audit TO portfolio_admin;

-- Grant read-only to portfolio_public (can view audit logs if needed)
GRANT USAGE ON SCHEMA audit TO portfolio_public;
GRANT SELECT ON ALL TABLES IN SCHEMA audit TO portfolio_public;

-- Set default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA audit GRANT SELECT,
INSERT ON TABLES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA audit GRANT USAGE,
SELECT ON SEQUENCES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA audit GRANT SELECT ON TABLES TO portfolio_public;
