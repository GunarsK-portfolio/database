# GitHub Actions CI/CD

## Workflows

### CI Pipeline (`ci.yml`)

Comprehensive continuous integration pipeline that runs on:

- Pull requests to `main` or `develop`
- Pushes to `main` or `develop`
- Manual workflow dispatch

**Jobs:**

1. **YAML Lint** - Validate YAML syntax and formatting
2. **Docker Compose Validation** - Ensure docker-compose.yml is valid
3. **Flyway Migration Test** - Run migrations against real PostgreSQL database
   - Validates migration file naming convention
   - Verifies migrations are in chronological order
   - Actually executes migrations to ensure they work
4. **SQL Lint** - Check SQL code quality with sqlfluff
5. **Secret Scanning** - Detect exposed secrets with TruffleHog
6. **Markdown Lint** - Validate Markdown documentation

**Security Features:**

- Secret scanning to prevent credential leaks
- Actual migration execution against test database
- SQL linting to maintain code quality

## Required GitHub Secrets

Configure these secrets in your repository:
**Settings → Secrets and variables → Actions → New repository secret**

| Secret | Description | Example Value |
|--------|-------------|---------------|
| `CI_DB_USER` | PostgreSQL superuser for CI tests | `postgres` |
| `CI_DB_PASSWORD` | Password for CI database | `test_password_123` |
| `CI_DB_NAME` | Database name for CI tests (must be `postgres` for pg_cron) | `postgres` |

These credentials are only used for temporary test databases created during CI runs.

## Status Badges

Add these to your README.md:

```markdown
![CI](https://github.com/GunarsK-portfolio/database/workflows/CI/badge.svg)
```

## Local Testing

Using Task:

```bash
task validate          # Validate docker-compose.yml
task lint-yaml         # Lint YAML files
task check-migrations  # Validate migration file naming
task lint-sql          # Lint SQL migration files
task ci                # Run all CI checks locally
task install-tools     # Install required linting tools
```

## Configuration Files

- `.yamllint.yml` - YAML linting rules
- `.sqlfluff` - SQL linting rules (200 char line limit)
- `docker-compose.yml` - PostgreSQL and Flyway setup
- `migrations/` - Flyway versioned migration files

## Notes for Database Repository

This repository contains database schema and migrations:

- Flyway migrations must follow naming convention: `V{timestamp}__{description}.sql`
- Migrations must be in chronological order
- SQL code is linted for quality and consistency
- No build step - migrations run via Flyway
