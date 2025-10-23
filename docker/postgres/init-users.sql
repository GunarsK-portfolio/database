-- Bootstrap database users for CI testing
-- Note: Extensions (pg_stat_statements, pg_cron, pg_partman) are automatically
-- created by the postgres-image's /docker-entrypoint-initdb.d/init-extensions.sql
-- This script only needs to create users and grant them necessary permissions

-- OWNER USER (for Flyway migrations - DDL + CRUD access)
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'portfolio_owner') THEN
        CREATE ROLE portfolio_owner WITH LOGIN PASSWORD 'portfolio_owner_dev_pass';
        RAISE NOTICE 'Created role portfolio_owner';
    ELSE
        RAISE NOTICE 'Role portfolio_owner already exists';
    END IF;
END
$$;

-- Transfer database ownership to portfolio_owner (must be done as superuser)
ALTER DATABASE portfolio OWNER TO portfolio_owner;

-- Grant database connection and creation rights
GRANT CONNECT ON DATABASE portfolio TO portfolio_owner;
GRANT CREATE ON DATABASE portfolio TO portfolio_owner;

-- Grant all privileges on database
GRANT ALL PRIVILEGES ON DATABASE portfolio TO portfolio_owner;

-- Grant permissions on public schema (PostgreSQL 15+ requires explicit grants)
GRANT ALL PRIVILEGES ON SCHEMA public TO portfolio_owner;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO portfolio_owner;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO portfolio_owner;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO portfolio_owner;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO portfolio_owner;

COMMENT ON ROLE portfolio_owner IS 'Flyway migrations user - DDL and CRUD access';

-- ADMIN USER (for admin services - CRUD access)
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'portfolio_admin') THEN
        CREATE ROLE portfolio_admin WITH LOGIN PASSWORD 'portfolio_admin_dev_pass';
        RAISE NOTICE 'Created role portfolio_admin';
    ELSE
        RAISE NOTICE 'Role portfolio_admin already exists';
    END IF;
END
$$;

GRANT CONNECT ON DATABASE portfolio TO portfolio_admin;
COMMENT ON ROLE portfolio_admin IS 'Admin services user - CRUD only, no DDL';

-- PUBLIC USER (for public API - read-only access)
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'portfolio_public') THEN
        CREATE ROLE portfolio_public WITH LOGIN PASSWORD 'portfolio_public_dev_pass';
        RAISE NOTICE 'Created role portfolio_public';
    ELSE
        RAISE NOTICE 'Role portfolio_public already exists';
    END IF;
END
$$;

GRANT CONNECT ON DATABASE portfolio TO portfolio_public;
COMMENT ON ROLE portfolio_public IS 'Public API user - SELECT only';

-- =============================================================================
-- EXTENSION PERMISSIONS
-- =============================================================================
-- Extensions are created by postgres-image's 00-init-extensions.sql
-- Here we grant necessary permissions to application users

-- Grant pg_cron schema access to portfolio_owner (needed for scheduling jobs in migrations)
GRANT USAGE ON SCHEMA cron TO portfolio_owner;
GRANT ALL ON ALL TABLES IN SCHEMA cron TO portfolio_owner;

-- Grant pg_partman schema access to portfolio_owner (needed for partition management)
-- Transfer ownership of partman schema and all objects to allow partition management
ALTER SCHEMA partman OWNER TO portfolio_owner;
GRANT ALL ON SCHEMA partman TO portfolio_owner;
GRANT ALL ON ALL TABLES IN SCHEMA partman TO portfolio_owner;
GRANT ALL ON ALL SEQUENCES IN SCHEMA partman TO portfolio_owner;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA partman TO portfolio_owner;
ALTER TABLE partman.part_config OWNER TO portfolio_owner;
ALTER TABLE partman.part_config_sub OWNER TO portfolio_owner;
