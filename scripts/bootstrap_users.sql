-- =============================================================================
-- BOOTSTRAP ALL DATABASE USERS
-- =============================================================================
-- Manual script for creating ALL database users on existing databases.
-- Run this as PostgreSQL superuser.
--
-- Usage (local dev):
--   docker exec -i postgres psql -U postgres -d portfolio < scripts/bootstrap_users.sql
--
-- Usage (AWS RDS):
--   psql -h <rds-endpoint> -U portfolio_master -d portfolio -f scripts/bootstrap_users.sql
--
-- IMPORTANT: Replace placeholder passwords with secure values before running!
-- For production, use values from AWS Secrets Manager.
-- =============================================================================

-- =============================================================================
-- 1. OWNER USER (portfolio_owner)
-- =============================================================================
-- Used by Flyway for migrations - has DDL + CRUD access
-- This user should own all schemas and tables

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'portfolio_owner') THEN
        CREATE ROLE portfolio_owner WITH LOGIN PASSWORD 'CHANGE_ME_OWNER';
        RAISE NOTICE 'Created role portfolio_owner';
    ELSE
        RAISE NOTICE 'Role portfolio_owner already exists';
    END IF;
END
$$;

-- Transfer database ownership (must be done as superuser)
-- Note: Only run this on fresh databases or if ownership transfer is needed
-- ALTER DATABASE portfolio OWNER TO portfolio_owner;

-- Grant database connection and creation rights
GRANT CONNECT ON DATABASE portfolio TO portfolio_owner;
GRANT CREATE ON DATABASE portfolio TO portfolio_owner;
GRANT ALL PRIVILEGES ON DATABASE portfolio TO portfolio_owner;

-- Grant permissions on public schema (PostgreSQL 15+ requires explicit grants)
GRANT ALL PRIVILEGES ON SCHEMA public TO portfolio_owner;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO portfolio_owner;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO portfolio_owner;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO portfolio_owner;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO portfolio_owner;

COMMENT ON ROLE portfolio_owner IS 'Flyway migrations user - DDL and CRUD access';

-- =============================================================================
-- 2. ADMIN USER (portfolio_admin)
-- =============================================================================
-- Used by admin-api service - has CRUD access to most schemas

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'portfolio_admin') THEN
        CREATE ROLE portfolio_admin WITH LOGIN PASSWORD 'CHANGE_ME_ADMIN';
        RAISE NOTICE 'Created role portfolio_admin';
    ELSE
        RAISE NOTICE 'Role portfolio_admin already exists';
    END IF;
END
$$;

GRANT CONNECT ON DATABASE portfolio TO portfolio_admin;
COMMENT ON ROLE portfolio_admin IS 'Admin services user - CRUD only, no DDL';

-- =============================================================================
-- 3. PUBLIC USER (portfolio_public)
-- =============================================================================
-- Used by public-api service - has read-only access

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'portfolio_public') THEN
        CREATE ROLE portfolio_public WITH LOGIN PASSWORD 'CHANGE_ME_PUBLIC';
        RAISE NOTICE 'Created role portfolio_public';
    ELSE
        RAISE NOTICE 'Role portfolio_public already exists';
    END IF;
END
$$;

GRANT CONNECT ON DATABASE portfolio TO portfolio_public;
COMMENT ON ROLE portfolio_public IS 'Public API user - SELECT only';

-- =============================================================================
-- 4. MESSAGING USER (portfolio_messaging)
-- =============================================================================
-- Used by messaging-api service - has CRUD on messaging schema only

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'portfolio_messaging') THEN
        CREATE ROLE portfolio_messaging WITH LOGIN PASSWORD 'CHANGE_ME_MESSAGING';
        RAISE NOTICE 'Created role portfolio_messaging';
    ELSE
        RAISE NOTICE 'Role portfolio_messaging already exists';
    END IF;
END
$$;

GRANT CONNECT ON DATABASE portfolio TO portfolio_messaging;
COMMENT ON ROLE portfolio_messaging IS 'Messaging API user - CRUD on messaging schema only';

-- =============================================================================
-- VERIFICATION
-- =============================================================================
-- Display all created roles

SELECT
    rolname AS role_name,
    rolcanlogin AS can_login,
    COALESCE(obj_description(oid, 'pg_authid'), '(no description)') AS description
FROM pg_roles
WHERE rolname LIKE 'portfolio_%'
ORDER BY rolname;
