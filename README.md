# Portfolio Database

Database migrations and schemas for the portfolio microservices system using Flyway.

## Overview

This repository contains all database schemas, migrations, and seed data for the portfolio system. It uses PostgreSQL as the database and Flyway for migration management.

## Structure

```
database/
├── migrations/           # Versioned database migrations
│   ├── V1__create_users_table.sql
│   ├── V2__create_profile_table.sql
│   ├── V3__create_work_experience_table.sql
│   ├── V4__create_certifications_table.sql
│   ├── V5__create_miniature_projects_table.sql
│   └── V6__create_images_table.sql
├── seeds/               # Repeatable seed data scripts
│   ├── R__seed_admin_user.sql
│   └── R__seed_sample_data.sql
├── scripts/             # Utility scripts
├── docker-compose.yml   # Local development setup
├── flyway.conf         # Flyway configuration
└── README.md
```

## Database Schema

### Tables

#### users
Stores user authentication data for admin access.

| Column | Type | Description |
|--------|------|-------------|
| id | BIGSERIAL | Primary key |
| username | VARCHAR(50) | Unique username |
| email | VARCHAR(100) | Unique email |
| password_hash | VARCHAR(255) | Bcrypt password hash |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

#### profile
Stores personal profile information.

| Column | Type | Description |
|--------|------|-------------|
| id | BIGSERIAL | Primary key |
| full_name | VARCHAR(100) | Full name |
| title | VARCHAR(100) | Professional title |
| bio | TEXT | Biography |
| email | VARCHAR(100) | Contact email |
| phone | VARCHAR(20) | Contact phone |
| location | VARCHAR(100) | Location |
| avatar_url | VARCHAR(255) | Avatar image URL |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

#### work_experience
Stores work history.

| Column | Type | Description |
|--------|------|-------------|
| id | BIGSERIAL | Primary key |
| company | VARCHAR(100) | Company name |
| position | VARCHAR(100) | Job position |
| description | TEXT | Job description |
| start_date | DATE | Start date |
| end_date | DATE | End date (NULL if current) |
| is_current | BOOLEAN | Currently employed flag |
| display_order | INT | Display ordering |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

#### certifications
Stores certifications and credentials.

| Column | Type | Description |
|--------|------|-------------|
| id | BIGSERIAL | Primary key |
| name | VARCHAR(200) | Certification name |
| issuer | VARCHAR(100) | Issuing organization |
| issue_date | DATE | Issue date |
| expiry_date | DATE | Expiry date (NULL if no expiry) |
| credential_id | VARCHAR(100) | Credential ID |
| credential_url | VARCHAR(255) | Verification URL |
| display_order | INT | Display ordering |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

#### miniature_projects
Stores miniature painting projects.

| Column | Type | Description |
|--------|------|-------------|
| id | BIGSERIAL | Primary key |
| title | VARCHAR(200) | Project title |
| description | TEXT | Project description |
| completed_date | DATE | Completion date |
| display_order | INT | Display ordering |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

#### images
Stores images for miniature projects.

| Column | Type | Description |
|--------|------|-------------|
| id | BIGSERIAL | Primary key |
| miniature_project_id | BIGINT | Foreign key to miniature_projects |
| title | VARCHAR(200) | Image title |
| description | TEXT | Image description |
| s3_key | VARCHAR(500) | S3 object key |
| s3_bucket | VARCHAR(100) | S3 bucket name |
| url | VARCHAR(500) | Full image URL |
| display_order | INT | Display ordering |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

## Quick Start

### Prerequisites

- Docker Desktop
- Docker Compose

### Run Locally

```bash
# Start PostgreSQL and run migrations
docker-compose up -d

# View migration logs
docker-compose logs flyway

# Connect to database
docker-compose exec postgres psql -U portfolio_user -d portfolio
```

### Stop Services

```bash
docker-compose down

# Stop and remove data
docker-compose down -v
```

## Flyway Commands

### Run Migrations

```bash
docker-compose run flyway migrate
```

### Check Migration Status

```bash
docker-compose run flyway info
```

### Validate Migrations

```bash
docker-compose run flyway validate
```

### Clean Database (WARNING: Deletes all data)

```bash
docker-compose run flyway clean
```

## Migration Naming Convention

Flyway uses the following naming conventions:

- **Versioned Migrations**: `V{version}__{description}.sql`
  - Example: `V1__create_users_table.sql`
  - Run once in order

- **Repeatable Migrations**: `R__{description}.sql`
  - Example: `R__seed_admin_user.sql`
  - Run after versioned migrations when checksum changes

## Adding New Migrations

1. Create new migration file in `migrations/` folder
2. Follow naming convention: `V{next_version}__{description}.sql`
3. Write SQL migration
4. Test locally: `docker-compose run flyway migrate`
5. Commit and push

Example:
```bash
# Create migration
echo "CREATE TABLE test (id BIGSERIAL PRIMARY KEY);" > migrations/V7__create_test_table.sql

# Run migration
docker-compose run flyway migrate
```

## Seed Data

Seed scripts are in the `seeds/` folder and are repeatable migrations. They use `ON CONFLICT` clauses to safely insert sample data.

To update seed data:
1. Modify the appropriate `R__*.sql` file
2. Run migrations: `docker-compose run flyway migrate`

## Database Connection

### Local Development

```
Host: localhost
Port: 5432
Database: portfolio
Username: portfolio_user
Password: portfolio_pass
```

### Connection String

```
postgresql://portfolio_user:portfolio_pass@localhost:5432/portfolio
```

## Backup and Restore

### Backup

```bash
docker-compose exec postgres pg_dump -U portfolio_user portfolio > backup.sql
```

### Restore

```bash
docker-compose exec -T postgres psql -U portfolio_user portfolio < backup.sql
```

## Production Deployment

For AWS RDS:

1. Set environment variables:
```bash
export FLYWAY_URL=jdbc:postgresql://your-rds-endpoint:5432/portfolio
export FLYWAY_USER=your_user
export FLYWAY_PASSWORD=your_password
```

2. Run migrations:
```bash
flyway migrate
```

## Troubleshooting

### Migration Failed

```bash
# Check flyway logs
docker-compose logs flyway

# Repair flyway schema history
docker-compose run flyway repair
```

### Reset Database

```bash
# WARNING: This deletes all data
docker-compose down -v
docker-compose up -d
```

### Connection Issues

```bash
# Check PostgreSQL is running
docker-compose ps

# Check PostgreSQL logs
docker-compose logs postgres
```

## Related Repositories

- [infrastructure](https://github.com/GunarsK-portfolio/infrastructure)
- [auth-service](https://github.com/GunarsK-portfolio/auth-service)
- [public-api](https://github.com/GunarsK-portfolio/public-api)
- [admin-api](https://github.com/GunarsK-portfolio/admin-api)

## License

MIT
