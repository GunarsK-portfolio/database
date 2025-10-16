-- Configure database user permissions
-- NOTE: Users are created and initial permissions granted by init-users.sql
-- This migration re-applies permissions for documentation and ensures consistency

-- =============================================================================
-- 1. OWNER USER (for migrations and DDL)
-- =============================================================================
-- Ensure portfolio_owner has all necessary privileges (already granted in init script)
GRANT ALL PRIVILEGES ON DATABASE portfolio TO portfolio_owner;
GRANT ALL PRIVILEGES ON SCHEMA public TO portfolio_owner;


-- =============================================================================
-- 2. ADMIN USER (for admin services - CRUD access)
-- =============================================================================
-- Basic permissions - detailed schema permissions granted in V20251016135900
GRANT CONNECT ON DATABASE portfolio TO portfolio_admin;


-- =============================================================================
-- 3. PUBLIC USER (for public API - read-only access)
-- =============================================================================
-- Basic permissions - detailed schema permissions granted in V20251016135900
GRANT CONNECT ON DATABASE portfolio TO portfolio_public;


-- =============================================================================
-- NOTES
-- =============================================================================
--
-- After this migration runs, the schemas migration (V20251016135900) will:
-- - Grant CRUD permissions to portfolio_admin
-- - Grant SELECT permissions to portfolio_public
--
-- Connection strings:
-- - Flyway:     postgresql://portfolio_owner:password@localhost:5432/portfolio
-- - Admin API:  postgresql://portfolio_admin:password@localhost:5432/portfolio
-- - Public API: postgresql://portfolio_public:password@localhost:5432/portfolio
--
-- IMPORTANT: Change passwords in production!
-- You should use environment variables or secrets management for passwords.
