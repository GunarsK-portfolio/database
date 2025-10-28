# Database

![CI](https://github.com/GunarsK-portfolio/database/workflows/CI/badge.svg)

PostgreSQL database schema with Flyway migrations for the portfolio project.

## Overview

This repository contains:
- Database schema migrations (Flyway versioned)
- Seed data for development
- Database setup scripts
- Audit logging for data changes
- Query performance monitoring (optional)

📖 **[Full Schema Documentation](docs/SCHEMA.md)** - Detailed table definitions, relationships, and column descriptions

## Tech Stack

- **Database**: PostgreSQL 18
- **Migration Tool**: Flyway 11
- **Extensions**: pg_stat_statements (query performance)

## Database Architecture

### Schemas

| Schema | Purpose | Tables |
|--------|---------|--------|
| `auth` | Authentication | users |
| `portfolio` | Professional portfolio | profile, work_experience, certifications, portfolio_projects, skills, project_technologies, cl_skill_types |
| `miniatures` | Miniature painting | miniature_themes, miniature_projects, miniature_techniques, miniature_paints, miniature_files, cl_techniques, cl_paints |
| `storage` | File storage (S3) | files |
| `audit` | Change tracking | change_log, query_stats (view) |

### Database Users

| User | Password (dev) | Purpose |
|------|----------------|---------|
| `portfolio_owner` | portfolio_owner_dev_pass | Flyway migrations (DDL) |
| `portfolio_admin` | portfolio_admin_dev_pass | Admin API (CRUD) |
| `portfolio_public` | portfolio_public_dev_pass | Public API (SELECT only) |

⚠️ **Change passwords in production!**

## Quick Start

### Using Docker Compose (Recommended)

```bash
# From database directory
docker-compose up

# Or from infrastructure directory
docker-compose up -d
```

Migrations run automatically on startup.

### Manual Migration

```bash
# Ensure PostgreSQL is running
docker-compose up -d postgres

# Run migrations
docker-compose run --rm flyway migrate
```

## Migrations

**23 versioned migrations** + **5 seed files** = Complete database setup

Includes:
- Database users and schemas
- Core tables (users, profile, work experience, certifications, projects, skills)
- Miniature painting tables (themes, projects, techniques, paints, files)
- Audit logging with automatic triggers
- Query performance monitoring setup
- Seed data: admin user, 120+ paints, 20 techniques, skill types, sample portfolio data

## Features

### Audit Logging ✅

All data changes (INSERT/UPDATE/DELETE) are automatically tracked in `audit.change_log`.

**View audit trail:**
```sql
SELECT * FROM audit.change_log
WHERE table_name = 'portfolio_projects'
  AND record_id = 123
ORDER BY changed_at DESC;
```

### Query Performance Monitoring ✅ (Optional)

Track query execution times with `pg_stat_statements`.

**View slow queries:**
```sql
SELECT * FROM audit.query_stats
WHERE mean_exec_time > 100
ORDER BY total_exec_time DESC;
```

## Database Connection

### Connection Strings

```bash
# Owner (for migrations)
postgresql://portfolio_owner:portfolio_owner_dev_pass@localhost:5432/portfolio

# Admin (for admin-api, auth-service)
postgresql://portfolio_admin:portfolio_admin_dev_pass@localhost:5432/portfolio

# Public (for public-api)
postgresql://portfolio_public:portfolio_public_dev_pass@localhost:5432/portfolio
```

### Access via psql

```bash
# As admin user
docker exec -it postgres psql -U portfolio_admin -d portfolio

# As owner (for migrations)
docker exec -it postgres psql -U portfolio_owner -d portfolio
```

## Creating New Migrations

1. Create file with timestamp:
```bash
# Format: V{YYYYMMDDHHMMSS}__{description}.sql
touch migrations/V20251016150000__add_new_table.sql
```

2. Write SQL:
```sql
CREATE TABLE portfolio.new_table (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add audit trigger
CREATE TRIGGER audit_new_table
    AFTER INSERT OR UPDATE OR DELETE ON portfolio.new_table
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();
```

3. Apply migration:
```bash
docker-compose run --rm flyway migrate
```

## Integration

This database is used by:

| Service | User | Access |
|---------|------|--------|
| Flyway | portfolio_owner | DDL + CRUD |
| auth-service | portfolio_admin | CRUD |
| admin-api | portfolio_admin | CRUD |
| public-api | portfolio_public | SELECT only |

## Backup and Restore

### Backup
```bash
docker exec postgres pg_dump -U portfolio_owner portfolio > backup_$(date +%Y%m%d).sql
```

### Restore
```bash
docker exec -i postgres psql -U portfolio_owner portfolio < backup_20251016.sql
```

## Troubleshooting

### Check migration status
```bash
docker-compose run --rm flyway info
```

### View Flyway logs
```bash
docker logs flyway
```

### Reset database (⚠️ destroys all data)
```bash
# From infrastructure directory
docker-compose down -v
docker-compose up -d postgres
docker-compose run --rm flyway migrate
```

### Check database size
```sql
SELECT
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
FROM pg_tables
WHERE schemaname IN ('auth', 'portfolio', 'miniatures', 'storage', 'audit')
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

## Development

### Local setup

1. Start PostgreSQL:
```bash
docker-compose up -d postgres
```

2. Run migrations:
```bash
docker-compose run --rm flyway migrate
```

3. Connect with your favorite client:
- DBeaver
- pgAdmin
- psql
- TablePlus

### Flyway commands

```bash
# Run migrations
docker-compose run --rm flyway migrate

# Check status
docker-compose run --rm flyway info

# Validate checksums
docker-compose run --rm flyway validate

# Repair migration history
docker-compose run --rm flyway repair
```

## Available Commands

This project uses [Task](https://taskfile.dev) for development commands:

```bash
# Database operations
task db:up            # Start PostgreSQL database with Docker Compose
task db:down          # Stop database
task db:logs          # View database logs
task db:clean         # Remove database and volumes (destroys data)
task db:console       # Connect to database with psql
task db:migrate       # Run Flyway migrations
task db:validate      # Validate Flyway migrations

# CI/CD checks
task ci:all               # Run all CI checks (validate, lint, check migrations)
task ci:validate          # Validate docker-compose configuration
task ci:lint-yaml         # Lint YAML files with yamllint
task ci:lint-sql          # Lint SQL migration files with sqlfluff
task ci:check-migrations  # Validate migration file naming and ordering
task dev:install-tools    # Install CI/CD tools (yamllint, sqlfluff, markdownlint-cli2)
```

## License

MIT
