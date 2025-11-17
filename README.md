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

📖 **[Full Schema Documentation](docs/SCHEMA.md)** - Detailed table
definitions, relationships, and column descriptions

## Tech Stack

- **Database**: PostgreSQL 18
- **Migration Tool**: Flyway 11
- **Extensions**: pg_stat_statements (query performance)

## Database Architecture

### Schemas

| Schema | Purpose | Tables |
|--------|---------|--------|
| `auth` | Authentication | users |
| `portfolio` | Professional portfolio | profile, work_experience, certifications, projects, skills |
| `miniatures` | Miniature painting | themes, projects, techniques, paints, files |
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
- Seed data: admin user, 120+ paints, 20 techniques, skill types,
  sample portfolio data

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

1. Write SQL:

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

1. Apply migration:

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

1. Run migrations:

```bash
docker-compose run --rm flyway migrate
```

1. Connect with your favorite client:

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

## Production Deployment

### Prerequisites

**GitHub Secrets Required:**

- `AWS_ROLE_ARN` - OIDC role ARN for AWS authentication (e.g., `arn:aws:iam::123456789012:role/GitHubActionsRole`)

**Configuration:**

- AWS region is set to `eu-west-1` by default in the workflow. Override by setting `AWS_REGION` secret if deploying to a different region.

**AWS Resources Required:**

- Aurora Serverless v2 database (created by infrastructure)
- Secrets Manager secret: `portfolio/prod/database/credentials` containing:

  ```json
  {
    "host": "aurora-endpoint.region.rds.amazonaws.com",
    "port": "5432",
    "dbname": "portfolio",
    "username": "portfolio_owner",
    "password": "secure-production-password"
  }
  ```

### Deployment Workflow

The database uses tag-based deployment via GitHub Actions:

```bash
# 1. Ensure infrastructure is deployed first (Aurora database exists)
# 2. Commit migration changes to main/develop
# 3. Create and push a version tag
git tag v1.0.0
git push origin v1.0.0

# This triggers .github/workflows/deploy.yml which:
# - Authenticates to AWS via OIDC
# - Retrieves Aurora credentials from Secrets Manager
# - Verifies database connectivity
# - Shows pending migrations
# - Runs Flyway migrations
# - Verifies successful application
```

### Pre-Deployment Safety Checklist

Before running migrations in production:

1. **Create Aurora Snapshot**
   ```bash
   aws rds create-db-cluster-snapshot \
     --db-cluster-snapshot-identifier portfolio-pre-deploy-$(date +%Y%m%d-%H%M%S) \
     --db-cluster-identifier portfolio-aurora-cluster \
     --region eu-west-1
   ```

2. **Verify Automated Backups Enabled**
   - Check Aurora cluster has automated backups with retention > 7 days
   - Confirm backup window doesn't conflict with deployment time

3. **Review Pending Migrations**
   - Check GitHub Actions workflow logs for pending migration list
   - Review migration SQL files for destructive operations

4. **Understand Flyway Behavior**
   - **Idempotency**: Flyway tracks applied migrations in `flyway_schema_history` table, preventing re-application
   - **No Rollback**: Production does not use Flyway undo scripts; recovery requires restoring from snapshot
   - **Validation**: Flyway validates migration checksums before applying new migrations

5. **Recovery Plan**
   - If deployment fails: Review error logs, fix migration, create new tag
   - If data corruption occurs: Restore from snapshot created in step 1
   - Expected RTO (Recovery Time Objective): ~15-30 minutes for snapshot restore

**Environment Protection:**

The production deployment requires GitHub environment protection to be configured:

- Go to repository Settings → Environments → production
- Configure deployment protection rules (required reviewers, wait timer, etc.)
- Add deployment branch/tag rules to allow `v*` tags

### Manual Deployment

For manual migration deployment (alternative to workflow):

```bash
# 1. Get Aurora endpoint from AWS Console or Terraform outputs
# 2. Get credentials from AWS Secrets Manager
aws secretsmanager get-secret-value \
  --secret-id portfolio/prod/database/credentials \
  --region eu-west-1

# 3. Run Flyway migrations
docker run --rm \
  -v ./migrations:/flyway/sql \
  flyway/flyway:11 \
  -url=jdbc:postgresql://<aurora-endpoint>:5432/portfolio \
  -user=portfolio_owner \
  -password=<password> \
  migrate
```

**Security Notes:**

- Never commit production credentials to Git
- Credentials are stored in AWS Secrets Manager
- Workflow uses OIDC (no long-lived credentials)
- Passwords are masked in GitHub Actions logs
- Seed scripts are NOT run in production

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
task ci:all               # Run all CI checks
task ci:validate          # Validate docker-compose configuration
task ci:lint-yaml         # Lint YAML files with yamllint
task ci:lint-sql          # Lint SQL migration files with sqlfluff
task ci:lint-markdown     # Lint Markdown files with markdownlint-cli2
task ci:check-migrations  # Validate migration file naming and ordering
task ci:install-tools     # Install CI/CD tools (yamllint, sqlfluff, markdownlint-cli2)

```

## License

MIT
