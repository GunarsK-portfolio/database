-- Create messaging schema for contact form and email delivery
-- NOTE: The portfolio_messaging user is created by init-users.sql.template (runs as superuser)
-- This migration only creates the schema and grants permissions
CREATE SCHEMA IF NOT EXISTS messaging;

-- =============================================================================
-- PERMISSIONS FOR portfolio_messaging
-- =============================================================================
-- Grant schema usage
GRANT USAGE ON SCHEMA messaging TO portfolio_messaging;

-- Grant table CRUD permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA messaging TO portfolio_messaging;

-- Grant sequence permissions (needed for auto-increment IDs with GORM)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA messaging TO portfolio_messaging;

-- Grant permissions on future tables/sequences created by portfolio_owner
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA messaging GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO portfolio_messaging;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA messaging GRANT USAGE, SELECT ON SEQUENCES TO portfolio_messaging;

-- =============================================================================
-- PERMISSIONS FOR portfolio_admin (for admin CRUD on recipients)
-- =============================================================================
-- Grant schema usage
GRANT USAGE ON SCHEMA messaging TO portfolio_admin;

-- Grant table CRUD permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA messaging TO portfolio_admin;

-- Grant sequence permissions
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA messaging TO portfolio_admin;

-- Grant permissions on future tables/sequences
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA messaging GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA messaging GRANT USAGE, SELECT ON SEQUENCES TO portfolio_admin;

-- =============================================================================
-- UPDATE DATABASE SEARCH PATH
-- =============================================================================
-- Add messaging schema to search_path for convenience
DO $$
BEGIN
    EXECUTE format('ALTER DATABASE %I SET search_path TO public, auth, portfolio, miniatures, storage, messaging', current_database());
END $$;

-- Add table comment
COMMENT ON SCHEMA messaging IS 'Contact form submissions and email delivery tracking';
