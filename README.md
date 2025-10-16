# Database

PostgreSQL database schema with Flyway migrations for the portfolio project.

## Overview

This repository contains:
- Database schema migrations (Flyway versioned)
- Seed data for development
- Flyway configuration
- Database setup scripts

## Tech Stack

- **Database**: PostgreSQL 18
- **Migration Tool**: Flyway 11
- **Version Control**: Flyway versioned migrations

## Prerequisites

- PostgreSQL 18+ (or use Docker Compose)
- Flyway CLI (optional, for local migrations)
- Java 11+ (required by Flyway)

## Database Schema

The database includes tables for:
- **users** - User accounts (auth)
- **profile** - Portfolio profile information
- **work_experience** - Work experience entries
- **certifications** - Professional certifications
- **skills** - Technical skills with categorization
- **portfolio_projects** - Coding projects portfolio
- **project_technologies** - Skills used in projects (junction table)
- **miniature_projects** - Miniature painting projects
- **miniature_themes** - Gallery themes for organizing miniatures
- **images** - Image metadata and references

See [docs/SCHEMA.md](docs/SCHEMA.md) for detailed schema documentation.

## Quick Start

### Using Docker Compose

Migrations run automatically when starting the infrastructure:

```bash
# From infrastructure directory
docker-compose up -d
```

The Flyway service will:
1. Wait for PostgreSQL to be healthy
2. Run all versioned migrations (V*.sql)
3. Run repeatable migrations (R*.sql - seeds)
4. Exit when complete

### Manual Migration with Flyway CLI

1. Ensure PostgreSQL is running

2. Update [flyway.conf](flyway.conf) with your connection details:
```properties
flyway.url=jdbc:postgresql://localhost:5432/portfolio
flyway.user=portfolio_user
flyway.password=portfolio_pass
flyway.locations=filesystem:./migrations
flyway.baselineOnMigrate=true
```

3. Run migrations:
```bash
flyway -configFiles=flyway.conf migrate
```

## Migration Files

### Versioned Migrations (`migrations/`)

Format: `V{version}__{description}.sql`

**Schema Migrations:**
| File | Description |
|------|-------------|
| `V20251016140000__create_users_table.sql` | Users table for authentication |
| `V20251016140100__create_profile_table.sql` | Portfolio profile |
| `V20251016140200__create_work_experience_table.sql` | Work experience entries |
| `V20251016140300__create_certifications_table.sql` | Professional certifications |
| `V20251016140400__create_miniature_projects_table.sql` | Miniature painting projects |
| `V20251016140500__create_images_table.sql` | Image metadata |
| `V20251016140600__create_portfolio_projects_table.sql` | Coding projects |
| `V20251016140700__create_skills_table.sql` | Technical skills |
| `V20251016140800__create_project_technologies_table.sql` | Project-skill relationships |
| `V20251016140900__create_miniature_themes_table.sql` | Gallery themes |
| `V20251016141000__add_miniature_projects_theme.sql` | Add theme FK to miniatures |
| `V20251016141100__add_miniature_projects_details.sql` | Add miniature details fields |
| `V20251016141200__add_portfolio_projects_featured.sql` | Add featured flag |

### Repeatable Migrations (`seeds/`)

Format: `R__{description}.sql`

| File | Description |
|------|-------------|
| `R__seed_admin_user.sql` | Default admin user |
| `R__seed_sample_data.sql` | Sample portfolio data |

Repeatable migrations run after versioned migrations and re-run whenever their content changes.

## Flyway Commands

Using Flyway CLI:

```bash
# Run migrations
flyway -configFiles=flyway.conf migrate

# Check migration status
flyway -configFiles=flyway.conf info

# Validate migrations
flyway -configFiles=flyway.conf validate

# Baseline existing database
flyway -configFiles=flyway.conf baseline

# Clean database (DANGER: deletes all data)
flyway -configFiles=flyway.conf clean
```

## Creating New Migrations

1. Create a new versioned migration file:
```bash
# Format: V{timestamp}__{description}.sql
# Example:
touch migrations/V20241010120000__add_tags_table.sql
```

2. Write your SQL:
```sql
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

3. Run migrations to apply:
```bash
flyway -configFiles=flyway.conf migrate
```

## Seed Data

Seed files in `seeds/` directory:
- `R__seed_admin_user.sql` - Creates default admin account
- `R__seed_sample_data.sql` - Adds sample portfolio content

These run automatically when using Docker Compose.

## Database Connection

Default connection details:

| Parameter | Value |
|-----------|-------|
| **Host** | `localhost` |
| **Port** | `5432` |
| **Database** | `portfolio` |
| **User** | `portfolio_user` |
| **Password** | `portfolio_pass` |

### Connection String
```
postgresql://portfolio_user:portfolio_pass@localhost:5432/portfolio
```

## Accessing Database

### Using Docker
```bash
docker exec -it postgres psql -U portfolio_user -d portfolio
```

### Using psql directly
```bash
psql -h localhost -U portfolio_user -d portfolio
```

## Backup and Restore

### Backup
```bash
docker exec postgres pg_dump -U portfolio_user portfolio > backup.sql
```

### Restore
```bash
docker exec -i postgres psql -U portfolio_user portfolio < backup.sql
```

## Development

For local development:

1. Start PostgreSQL:
```bash
# From infrastructure directory
docker-compose up -d postgres
```

2. Run migrations:
```bash
flyway -configFiles=flyway.conf migrate
```

## Integration

This database is used by:
- **auth-service** - User authentication
- **public-api** - Read-only public content
- **admin-api** - Full CRUD operations

## Troubleshooting

### Migrations not running
Check Flyway container logs:
```bash
docker logs flyway
```

### Database connection issues
Verify PostgreSQL is running and healthy:
```bash
docker-compose ps postgres
docker exec postgres pg_isready
```

### Reset database
```bash
# From infrastructure directory
docker-compose down -v  # Remove volumes
docker-compose up -d    # Recreate and run migrations
```

## License

MIT
