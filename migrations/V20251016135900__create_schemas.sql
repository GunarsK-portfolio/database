-- Create schemas for organizing database objects by domain
-- This improves organization, security, and maintainability

-- Authentication & User Management
CREATE SCHEMA IF NOT EXISTS auth;

-- Portfolio content (work experience, projects, skills, etc.)
CREATE SCHEMA IF NOT EXISTS portfolio;

-- Miniatures gallery and related data
CREATE SCHEMA IF NOT EXISTS miniatures;

-- File storage (S3 references)
CREATE SCHEMA IF NOT EXISTS storage;

-- =============================================================================
-- PERMISSIONS FOR portfolio_admin (Application Runtime User)
-- =============================================================================
-- This user has CRUD access but CANNOT modify schema

-- Grant schema usage
GRANT USAGE ON SCHEMA auth TO portfolio_admin;
GRANT USAGE ON SCHEMA portfolio TO portfolio_admin;
GRANT USAGE ON SCHEMA miniatures TO portfolio_admin;
GRANT USAGE ON SCHEMA storage TO portfolio_admin;

-- Grant table CRUD permissions (SELECT, INSERT, UPDATE, DELETE)
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA auth TO portfolio_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA portfolio TO portfolio_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA miniatures TO portfolio_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA storage TO portfolio_admin;

-- Grant sequence permissions (needed for auto-increment IDs with GORM)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA auth TO portfolio_admin;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA portfolio TO portfolio_admin;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA miniatures TO portfolio_admin;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA storage TO portfolio_admin;

-- Grant permissions on future tables/sequences created by portfolio_owner
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA auth GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA portfolio GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA miniatures GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA storage GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO portfolio_admin;

ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA auth GRANT USAGE, SELECT ON SEQUENCES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA portfolio GRANT USAGE, SELECT ON SEQUENCES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA miniatures GRANT USAGE, SELECT ON SEQUENCES TO portfolio_admin;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA storage GRANT USAGE, SELECT ON SEQUENCES TO portfolio_admin;

-- =============================================================================
-- PERMISSIONS FOR portfolio_public (Optional - Read-Only User)
-- =============================================================================
-- This user can only SELECT data, useful for public-facing services

-- Grant schema usage
GRANT USAGE ON SCHEMA auth TO portfolio_public;
GRANT USAGE ON SCHEMA portfolio TO portfolio_public;
GRANT USAGE ON SCHEMA miniatures TO portfolio_public;
GRANT USAGE ON SCHEMA storage TO portfolio_public;

-- Grant SELECT only on all tables
GRANT SELECT ON ALL TABLES IN SCHEMA auth TO portfolio_public;
GRANT SELECT ON ALL TABLES IN SCHEMA portfolio TO portfolio_public;
GRANT SELECT ON ALL TABLES IN SCHEMA miniatures TO portfolio_public;
GRANT SELECT ON ALL TABLES IN SCHEMA storage TO portfolio_public;

-- Grant permissions on future tables created by portfolio_owner
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA auth GRANT SELECT ON TABLES TO portfolio_public;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA portfolio GRANT SELECT ON TABLES TO portfolio_public;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA miniatures GRANT SELECT ON TABLES TO portfolio_public;
ALTER DEFAULT PRIVILEGES FOR ROLE portfolio_owner IN SCHEMA storage GRANT SELECT ON TABLES TO portfolio_public;

-- Set search_path to include all schemas for convenience
-- This allows you to reference tables without schema prefix in GORM
ALTER DATABASE portfolio SET search_path TO public, auth, portfolio, miniatures, storage;
