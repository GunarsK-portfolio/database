# Database Schema

## Tables

### users
Authentication accounts for admin users.

**Columns:**
- `id` - BIGSERIAL PRIMARY KEY
- `username` - VARCHAR(50) UNIQUE NOT NULL
- `email` - VARCHAR(100) UNIQUE NOT NULL
- `password_hash` - VARCHAR(255) NOT NULL (bcrypt)
- `created_at`, `updated_at` - TIMESTAMP

**Indexes:** username, email

---

### profile
Portfolio owner information (singleton - one row).

**Columns:**
- `id` - BIGSERIAL PRIMARY KEY
- `full_name` - VARCHAR(100) NOT NULL
- `title` - VARCHAR(100) (professional title)
- `bio` - TEXT
- `email` - VARCHAR(100)
- `phone` - VARCHAR(20)
- `location` - VARCHAR(100)
- `avatar_url` - VARCHAR(255)
- `created_at`, `updated_at` - TIMESTAMP

---

### work_experience
Employment history entries.

**Columns:**
- `id` - BIGSERIAL PRIMARY KEY
- `company` - VARCHAR(100) NOT NULL
- `position` - VARCHAR(100) NOT NULL
- `description` - TEXT
- `start_date` - DATE NOT NULL
- `end_date` - DATE (NULL if current)
- `is_current` - BOOLEAN DEFAULT FALSE
- `display_order` - INT DEFAULT 0
- `created_at`, `updated_at` - TIMESTAMP

**Indexes:** display_order

---

### certifications
Professional certifications.

**Columns:**
- `id` - BIGSERIAL PRIMARY KEY
- `name` - VARCHAR(200) NOT NULL
- `issuer` - VARCHAR(100) NOT NULL
- `issue_date` - DATE NOT NULL
- `expiry_date` - DATE
- `credential_id` - VARCHAR(100)
- `credential_url` - VARCHAR(255)
- `display_order` - INT DEFAULT 0
- `created_at`, `updated_at` - TIMESTAMP

**Indexes:** display_order

---

### miniature_projects
Portfolio projects.

**Columns:**
- `id` - BIGSERIAL PRIMARY KEY
- `title` - VARCHAR(200) NOT NULL
- `description` - TEXT
- `completed_date` - DATE
- `display_order` - INT DEFAULT 0
- `created_at`, `updated_at` - TIMESTAMP

**Indexes:** display_order

**Relationships:** One-to-many with images

---

### images
Image metadata and S3/MinIO references.

**Columns:**
- `id` - BIGSERIAL PRIMARY KEY
- `miniature_project_id` - BIGINT FK → miniature_projects(id) ON DELETE CASCADE
- `title` - VARCHAR(200)
- `description` - TEXT
- `s3_key` - VARCHAR(500) NOT NULL
- `s3_bucket` - VARCHAR(100) NOT NULL
- `url` - VARCHAR(500) NOT NULL
- `display_order` - INT DEFAULT 0
- `created_at`, `updated_at` - TIMESTAMP

**Indexes:** miniature_project_id, display_order

**Relationships:** Many-to-one with miniature_projects (cascade delete)

---

## Relationships

- **miniature_projects** → **images** (1:N, cascade delete)

## Common Features

### Auto-Updating Timestamps
All tables have triggers that auto-update `updated_at` on modification.

### Display Ordering
Tables with `display_order`: work_experience, certifications, miniature_projects, images
Lower values = displayed first

## Migration Files

**Versioned migrations** (`migrations/`):
1. V20241009140000__create_users_table.sql
2. V20241009140100__create_profile_table.sql
3. V20241009140200__create_work_experience_table.sql
4. V20241009140300__create_certifications_table.sql
5. V20241009140400__create_miniature_projects_table.sql
6. V20241009140500__create_images_table.sql

**Seed data** (`seeds/`):
- R__seed_admin_user.sql - Default admin
- R__seed_sample_data.sql - Sample portfolio data

## Connection Info

**Development:**
```
postgresql://portfolio_user:portfolio_pass@localhost:5432/portfolio
```

**Docker Internal:**
```
postgresql://portfolio_user:portfolio_pass@postgres:5432/portfolio
```
