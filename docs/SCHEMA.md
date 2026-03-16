# Database Schema Documentation

## Overview

PostgreSQL 18 database with 6 schemas, 25 tables, and 4-tier user security model.

## Schemas

- **auth** - Authentication, user management, and RBAC
- **portfolio** - Professional portfolio content (work experience, projects, skills)
- **miniatures** - Miniature painting projects and related data
- **messaging** - Email messages and delivery tracking
- **storage** - Generic S3 file storage
- **audit** - Audit logging and change tracking

## Database Users

| User | Role | Access Level |
| ---- | ---- | ------------ |
| portfolio_owner | DDL | Full database ownership, schema changes |
| portfolio_admin | CRUD | INSERT, UPDATE, DELETE, SELECT on all tables |
| portfolio_messaging | CRUD | INSERT, UPDATE, DELETE, SELECT on messaging schema |
| portfolio_public | Read-only | SELECT only on all tables |

## Tables by Schema

### auth schema

#### users

Authentication users for admin portal access.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique user identifier |
| username | VARCHAR(50) | UNIQUE, NOT NULL | Unique username for login |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Unique email address |
| password_hash | VARCHAR(255) | NOT NULL | Bcrypt hashed password |
| email_verified | BOOLEAN | NOT NULL, DEFAULT FALSE | Whether the user has verified their email address |
| display_name | VARCHAR(100) | | User-chosen display name (optional) |
| role_id | INT | FK → roles | User's role for RBAC permissions |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when user was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when user was last updated |

**Foreign Keys:**

- `role_id` → `auth.roles(id)`

**Indexes:**

- `idx_users_username` on username
- `idx_users_email` on email
- `idx_users_role_id` on role_id

**Triggers:**

- `update_users_updated_at` - Auto-updates updated_at on UPDATE

---

#### roles

User roles for role-based access control.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | SERIAL | PRIMARY KEY | Unique role identifier |
| code | VARCHAR(50) | UNIQUE, NOT NULL | Role code (e.g., admin, read-only) |
| name | VARCHAR(100) | NOT NULL | Human-readable role name |
| created_at | TIMESTAMPTZ | DEFAULT NOW() | Timestamp when role was created |

**Seed Data:** admin, read-only

---

#### resources

Protected resources for permission assignments.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | SERIAL | PRIMARY KEY | Unique resource identifier |
| code | VARCHAR(50) | UNIQUE, NOT NULL | Resource code (e.g., profile, projects) |
| name | VARCHAR(100) | NOT NULL | Human-readable resource name |
| created_at | TIMESTAMPTZ | DEFAULT NOW() | Timestamp when resource was created |

**Seed Data:** profile, work_experience, certifications, projects, skills,
miniatures, files, users, messages

---

#### role_scopes

Permission assignments linking roles to resources with access levels.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| role_id | INT | FK → roles, PK | Role reference |
| resource_id | INT | FK → resources, PK | Resource reference |
| permission_level | VARCHAR(10) | NOT NULL, CHECK | Access level: none, read, edit, delete |

**Foreign Keys:**

- `role_id` → `auth.roles(id)` ON DELETE CASCADE
- `resource_id` → `auth.resources(id)` ON DELETE CASCADE

**Primary Key:** (role_id, resource_id)

**Indexes:**

- `idx_role_scopes_role_id` on role_id

**Permission Hierarchy:** none(0) < read(1) < edit(2) < delete(3)

---

#### verification_tokens

Email verification tokens for user email confirmation.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique token identifier |
| user_id | BIGINT | FK → users, NOT NULL | Reference to the user requesting verification |
| email | VARCHAR(100) | NOT NULL | Email address being verified (may differ from current user email if changed) |
| token | VARCHAR(64) | UNIQUE, NOT NULL | Unique verification token (64 hex chars) |
| created_at | TIMESTAMPTZ | DEFAULT NOW() | Timestamp when token was generated |

**Foreign Keys:**

- `user_id` → `auth.users(id)` ON DELETE CASCADE

**Indexes:**

- `idx_verification_tokens_user_id` on user_id

---

### storage schema

#### files

Generic S3 file storage for images, PDFs, documents, and other files.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique file identifier |
| s3_key | VARCHAR(500) | UNIQUE, NOT NULL | Unique S3 object key (path in bucket) |
| s3_bucket | VARCHAR(100) | NOT NULL | S3 bucket name where file is stored |
| file_name | VARCHAR(255) | | Original filename uploaded by user |
| file_size | BIGINT | | File size in bytes |
| mime_type | VARCHAR(100) | | MIME type (e.g., image/png, application/pdf) |
| file_type | VARCHAR(50) | | Category for filtering: image, pdf, document, etc. |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when file was uploaded |

**Indexes:**

- `idx_files_s3_key` on s3_key
- `idx_files_file_type` on file_type

---

### portfolio schema

#### profile

Portfolio owner profile information (singleton table, should have exactly 1 row).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique profile identifier |
| full_name | VARCHAR(100) | NOT NULL | Full name of portfolio owner |
| title | VARCHAR(100) | | Professional title or headline |
| bio | TEXT | | Biography or about section (supports markdown) |
| email | VARCHAR(100) | | Public contact email address |
| phone | VARCHAR(20) | | Public contact phone number |
| location | VARCHAR(100) | | Current location (e.g., City, Country) |
| avatar_file_id | BIGINT | FK → storage.files | Profile photo stored in S3 |
| resume_file_id | BIGINT | FK → storage.files | Resume PDF stored in S3 |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when profile was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when profile was last updated |

**Foreign Keys:**

- `avatar_file_id` → `storage.files(id)` ON DELETE SET NULL
- `resume_file_id` → `storage.files(id)` ON DELETE SET NULL

**Triggers:**

- `update_profile_updated_at` - Auto-updates updated_at on UPDATE

---

#### work_experience

Work experience history for portfolio owner.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique work experience identifier |
| company | VARCHAR(100) | NOT NULL | Company or organization name |
| position | VARCHAR(100) | NOT NULL | Job title or position |
| description | TEXT | | Job responsibilities and achievements (supports markdown) |
| start_date | DATE | NOT NULL | Employment start date |
| end_date | DATE | | Employment end date (NULL if current position) |
| is_current | BOOLEAN | DEFAULT FALSE | Flag indicating if this is the current position |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when record was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when record was last updated |

**Indexes:**

- `idx_work_experience_start_date` on start_date DESC

**Triggers:**

- `update_work_experience_updated_at` - Auto-updates updated_at on UPDATE

---

#### certifications

Professional certifications and credentials.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique certification identifier |
| name | VARCHAR(200) | NOT NULL | Certification name (e.g., AWS Certified Solutions Architect) |
| issuer | VARCHAR(100) | NOT NULL | Issuing organization (e.g., Amazon Web Services) |
| issue_date | DATE | NOT NULL | Date when certification was issued |
| expiry_date | DATE | | Date when certification expires (NULL if no expiry) |
| credential_id | VARCHAR(100) | UNIQUE | Unique credential identifier from issuer |
| credential_url | VARCHAR(255) | | URL to verify certification |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when record was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when record was last updated |

**Indexes:**

- `idx_certifications_issue_date` on issue_date DESC
- `idx_certifications_credential_id` on credential_id

**Triggers:**

- `update_certifications_updated_at` - Auto-updates updated_at on UPDATE

---

#### portfolio_projects

Professional software development portfolio projects.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique project identifier |
| title | VARCHAR(200) | NOT NULL | Project title |
| category | VARCHAR(100) | | Project category (e.g., Web App, Mobile App, CLI Tool) |
| description | TEXT | | Short project description (1-2 sentences) |
| long_description | TEXT | | Detailed project description (supports markdown) |
| image_file_id | BIGINT | FK → storage.files | Project screenshot or thumbnail from S3 |
| github_url | VARCHAR(255) | | GitHub repository URL |
| live_url | VARCHAR(255) | | Live demo URL |
| start_date | DATE | | Project start date |
| end_date | DATE | | Project end date (NULL if ongoing) |
| is_ongoing | BOOLEAN | DEFAULT FALSE | Flag indicating if project is ongoing |
| team_size | INT | | Number of team members |
| role | VARCHAR(100) | | Your role in the project (e.g., Full Stack Developer) |
| featured | BOOLEAN | DEFAULT FALSE | Flag to feature this project on homepage/top of list |
| features | JSONB | DEFAULT '[]'::jsonb | Array of key features (JSONB array of strings) |
| challenges | JSONB | DEFAULT '[]'::jsonb | Array of technical challenges faced (JSONB array of strings) |
| learnings | JSONB | DEFAULT '[]'::jsonb | Array of learnings and takeaways (JSONB array of strings) |
| display_order | INT | DEFAULT 0 | Display order for sorting projects |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when project was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when project was last updated |

**Foreign Keys:**

- `image_file_id` → `storage.files(id)` ON DELETE SET NULL

**Indexes:**

- `idx_portfolio_projects_display_order` on display_order
- `idx_portfolio_projects_category` on category
- `idx_portfolio_projects_featured` on featured

**Triggers:**

- `update_portfolio_projects_updated_at` - Auto-updates updated_at on UPDATE

---

#### cl_skill_types

Skill categories classifier (e.g., Frontend, Backend, Database, DevOps).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique skill type identifier |
| name | VARCHAR(100) | UNIQUE, NOT NULL | Skill type name (e.g., Frontend, Backend, Database, DevOps) |
| description | TEXT | | Skill type description |
| display_order | INT | DEFAULT 0 | Display order for sorting skill types |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when skill type was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when skill type was last updated |

**Indexes:**

- `idx_skill_types_display_order` on display_order
- `idx_skill_types_name` on name

**Triggers:**

- `update_skill_types_updated_at` - Auto-updates updated_at on UPDATE

---

#### skills

Individual skills and technologies.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique skill identifier |
| skill | VARCHAR(100) | UNIQUE, NOT NULL | Skill or technology name (e.g., React, PostgreSQL, Docker) |
| skill_type_id | BIGINT | FK → cl_skill_types, NOT NULL | Skill category |
| is_visible | BOOLEAN | DEFAULT TRUE | Show in skills section (FALSE allows tracking project tech without displaying) |
| display_order | INT | DEFAULT 0 | Display order within skill type |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when skill was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when skill was last updated |

**Foreign Keys:**

- `skill_type_id` → `portfolio.cl_skill_types(id)` ON DELETE RESTRICT

**Indexes:**

- `idx_skills_type_id` on skill_type_id
- `idx_skills_is_visible` on is_visible
- `idx_skills_display_order` on display_order

**Triggers:**

- `update_skills_updated_at` - Auto-updates updated_at on UPDATE

---

#### project_technologies

Junction table linking portfolio projects to skills/technologies (many-to-many).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique identifier |
| project_id | BIGINT | FK → portfolio_projects, NOT NULL | Portfolio project |
| skill_id | BIGINT | FK → skills, NOT NULL | Skill or technology used |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when link was created |

**Foreign Keys:**

- `project_id` → `portfolio.portfolio_projects(id)` ON DELETE CASCADE
- `skill_id` → `portfolio.skills(id)` ON DELETE CASCADE

**Unique Constraints:**

- `(project_id, skill_id)` - One skill per project

**Indexes:**

- `idx_project_technologies_project_id` on project_id
- `idx_project_technologies_skill_id` on skill_id

---

### miniatures schema

#### miniature_themes

Thematic collections of miniature projects
(e.g., Stormlight Archive, Warhammer 40k).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique theme identifier |
| name | VARCHAR(100) | UNIQUE, NOT NULL | Theme name (e.g., Stormlight Archive) |
| description | TEXT | | Theme description (supports markdown) |
| cover_image_id | BIGINT | FK → storage.files | Cover image from S3 |
| display_order | INT | DEFAULT 0 | Display order for sorting themes |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when theme was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when theme was last updated |

**Foreign Keys:**

- `cover_image_id` → `storage.files(id)` ON DELETE SET NULL

**Indexes:**

- `idx_miniature_themes_display_order` on display_order
- `idx_miniature_themes_cover_image_id` on cover_image_id

**Triggers:**

- `update_miniature_themes_updated_at` - Auto-updates updated_at on UPDATE

---

#### miniature_projects

Individual miniature painting projects.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique project identifier |
| title | VARCHAR(200) | NOT NULL | Project title (e.g., Kaladin Stormblessed) |
| description | TEXT | | Project description, techniques used, notes (supports markdown) |
| completed_date | DATE | | Date when project was completed |
| scale | VARCHAR(50) | | Miniature scale (e.g., 28mm, 1:35, 75mm) |
| manufacturer | VARCHAR(100) | | Manufacturer or sculptor (e.g., Games Workshop, Reaper) |
| time_spent | NUMERIC(6,2) | | Hours spent on project (e.g., 12.5) |
| difficulty | VARCHAR(50) | | Difficulty level (Beginner, Intermediate, Advanced, Expert) |
| theme_id | BIGINT | FK → miniature_themes | Theme this project belongs to |
| display_order | INT | DEFAULT 0 | Display order within theme |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when project was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when project was last updated |

**Foreign Keys:**

- `theme_id` → `miniatures.miniature_themes(id)` ON DELETE SET NULL

**Indexes:**

- `idx_miniature_projects_display_order` on display_order
- `idx_miniature_projects_theme_id` on theme_id
- `idx_miniature_projects_difficulty` on difficulty
- `idx_miniature_projects_manufacturer` on manufacturer

**Triggers:**

- `update_miniature_projects_updated_at` - Auto-updates updated_at on UPDATE

---

#### cl_techniques

Master list of miniature painting techniques (classifier).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique technique identifier |
| name | VARCHAR(100) | UNIQUE, NOT NULL | Technique name (e.g., Drybrushing, NMM, Wet Blending) |
| description | TEXT | | Technique description and usage notes |
| difficulty_level | VARCHAR(50) | | Difficulty: Beginner, Intermediate, Advanced, Expert |
| display_order | INT | DEFAULT 0 | Display order for sorting techniques |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when technique was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when technique was last updated |

**Indexes:**

- `idx_techniques_name` on name
- `idx_techniques_difficulty` on difficulty_level
- `idx_techniques_display_order` on display_order

**Triggers:**

- `update_techniques_updated_at` - Auto-updates updated_at on UPDATE

---

#### cl_paints

Master list of miniature paints (classifier).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique paint identifier |
| name | VARCHAR(200) | NOT NULL | Paint name (e.g., Abaddon Black, Ushabti Bone) |
| manufacturer | VARCHAR(100) | NOT NULL | Manufacturer (e.g., AK Interactive, Army Painter) |
| color_hex | VARCHAR(7) | | Hex color code for display (e.g., #FF5733) |
| paint_type | VARCHAR(50) | CHECK constraint | Paint type: Base, Layer, Shade, Wash, Contrast, Dry, Technical, Metallic, Air, Primer, Edge, Glaze, Ink |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when paint was created |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when paint was last updated |

**Unique Constraints:**

- `(name, manufacturer)` - Unique paint per manufacturer

**Indexes:**

- `idx_paints_manufacturer` on manufacturer
- `idx_paints_name` on name
- `idx_paints_paint_type` on paint_type

**Triggers:**

- `update_paints_updated_at` - Auto-updates updated_at on UPDATE

---

#### miniature_techniques

Junction table linking miniature projects to painting techniques (many-to-many).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique identifier |
| miniature_project_id | BIGINT | FK → miniature_projects, NOT NULL | Miniature project |
| technique_id | BIGINT | FK → cl_techniques, NOT NULL | Painting technique used |
| notes | TEXT | | Optional notes about technique application (e.g., "used for metal armor") |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when link was created |

**Foreign Keys:**

- `miniature_project_id` → `miniatures.miniature_projects(id)` ON DELETE CASCADE
- `technique_id` → `miniatures.cl_techniques(id)` ON DELETE CASCADE

**Unique Constraints:**

- `(miniature_project_id, technique_id)` - One technique per project

**Indexes:**

- `idx_miniature_techniques_miniature_id` on miniature_project_id
- `idx_miniature_techniques_technique_id` on technique_id

---

#### miniature_paints

Junction table linking miniature projects to paints (many-to-many).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique identifier |
| miniature_project_id | BIGINT | FK → miniature_projects, NOT NULL | Miniature project |
| paint_id | BIGINT | FK → cl_paints, NOT NULL | Paint used |
| usage_notes | TEXT | | Optional notes about paint usage (e.g., "base coat for skin", "highlights") |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when link was created |

**Foreign Keys:**

- `miniature_project_id` → `miniatures.miniature_projects(id)` ON DELETE CASCADE
- `paint_id` → `miniatures.cl_paints(id)` ON DELETE CASCADE

**Unique Constraints:**

- `(miniature_project_id, paint_id)` - One paint per project

**Indexes:**

- `idx_miniature_paints_miniature_id` on miniature_project_id
- `idx_miniature_paints_paint_id` on paint_id

---

#### miniature_files

Junction table linking miniature projects to images (many-to-many).

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique identifier |
| miniature_project_id | BIGINT | FK → miniature_projects, NOT NULL | Miniature project |
| file_id | BIGINT | FK → storage.files, NOT NULL | Image file from S3 |
| caption | TEXT | | Optional image caption |
| display_order | INT | DEFAULT 0 | Order for displaying images in gallery |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when link was created |

**Foreign Keys:**

- `miniature_project_id` → `miniatures.miniature_projects(id)` ON DELETE CASCADE
- `file_id` → `storage.files(id)` ON DELETE CASCADE

**Unique Constraints:**

- `(miniature_project_id, file_id)` - One file per project

**Indexes:**

- `idx_miniature_files_miniature_id` on miniature_project_id
- `idx_miniature_files_file_id` on file_id
- `idx_miniature_files_display_order` on (miniature_project_id, display_order)

---

### messaging schema

#### emails

Email messages for all services.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique email identifier |
| type | VARCHAR(50) | NOT NULL, DEFAULT 'contact_form' | Email type: contact_form, email_verification, password_reset, 2fa_code |
| name | VARCHAR(100) | | Sender's name (contact forms only) |
| email | VARCHAR(255) | | Sender's email address (required for contact_form) |
| recipient_email | VARCHAR(255) | | Direct recipient email (required for auth emails) |
| subject | VARCHAR(200) | | Message subject line |
| message | TEXT | NOT NULL | Message content |
| status | VARCHAR(20) | DEFAULT 'pending' | Processing status: pending, queued, sent, failed |
| created_at | TIMESTAMPTZ | DEFAULT NOW() | Timestamp when email was created |
| updated_at | TIMESTAMPTZ | DEFAULT NOW() | Timestamp when email was last updated |

**Constraints:**

- `chk_emails_has_target` - contact_form requires email; auth types require recipient_email
- `chk_emails_email_format` - email format validation (allows NULL)
- `chk_emails_recipient_email_format` - recipient_email format validation
- `chk_emails_status` - status IN (pending, queued, sent, failed)
- `chk_emails_type` - type IN (contact_form, email_verification, etc.)

**Indexes:**

- `idx_emails_status` on status
- `idx_emails_created_at` on created_at DESC
- `idx_emails_email` on email
- `idx_emails_type` on type
- `idx_emails_recipient_email` on recipient_email

**Triggers:**

- `update_emails_updated_at` - Auto-updates updated_at on UPDATE
- `audit_emails` - Audit logging on INSERT, UPDATE, DELETE

---

#### recipients

Email recipients for contact message forwarding.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique recipient identifier |
| email | VARCHAR(255) | UNIQUE, NOT NULL | Recipient email address |
| name | VARCHAR(100) | | Recipient display name |
| is_active | BOOLEAN | DEFAULT TRUE | Whether recipient receives messages |
| created_at | TIMESTAMPTZ | DEFAULT NOW() | Timestamp when recipient was added |

**Indexes:**

- `idx_recipients_is_active` on is_active

---

#### delivery_attempts

Tracks email delivery attempts for each message-recipient pair.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique attempt identifier |
| message_id | BIGINT | FK → emails, NOT NULL | Email reference |
| recipient_id | BIGINT | FK → recipients, NOT NULL | Recipient reference |
| status | VARCHAR(20) | NOT NULL | Delivery status: pending, sent, failed |
| attempt_count | INT | DEFAULT 0 | Number of delivery attempts |
| last_attempt_at | TIMESTAMPTZ | | Timestamp of last delivery attempt |
| error_message | TEXT | | Error message if delivery failed |
| created_at | TIMESTAMPTZ | DEFAULT NOW() | Timestamp when attempt was created |

**Foreign Keys:**

- `message_id` → `messaging.emails(id)` ON DELETE CASCADE
- `recipient_id` → `messaging.recipients(id)` ON DELETE CASCADE

**Indexes:**

- `idx_delivery_attempts_message_id` on message_id
- `idx_delivery_attempts_recipient_id` on recipient_id
- `idx_delivery_attempts_status` on status

---

### audit schema

#### change_log

Audit trail of all data changes in the system.

| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | BIGSERIAL | PRIMARY KEY | Unique audit log identifier |
| table_name | VARCHAR(100) | NOT NULL | Name of the table that was modified |
| schema_name | VARCHAR(100) | NOT NULL | Schema name (auth, portfolio, miniatures, storage) |
| record_id | BIGINT | NOT NULL | ID of the record that was modified |
| action | VARCHAR(20) | NOT NULL | Action performed: INSERT, UPDATE, or DELETE |
| user_id | BIGINT | | User ID who made the change (NULL for system/migration changes) |
| username | VARCHAR(100) | | Username denormalized for easy querying |
| changed_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Timestamp when change occurred |
| old_data | JSONB | | JSONB snapshot of record before change (NULL for INSERT) |
| new_data | JSONB | | JSONB snapshot of record after change (NULL for DELETE) |
| changed_fields | TEXT[] | | Array of field names that were modified (UPDATE only) |
| client_ip | VARCHAR(50) | | Optional: client IP address for additional context |
| user_agent | TEXT | | Optional: client user agent for additional context |

**Indexes:**

- `idx_change_log_table_name` on table_name
- `idx_change_log_record_id` on record_id
- `idx_change_log_user_id` on user_id
- `idx_change_log_changed_at` on changed_at DESC
- `idx_change_log_action` on action
- `idx_change_log_table_record` on (table_name, record_id, changed_at DESC)
- `idx_change_log_user_time` on (user_id, changed_at DESC)

**Usage:**
Set user context before DML operations:

```sql
BEGIN;
SELECT set_config('app.current_user_id', '42', true);
SELECT set_config('app.current_username', 'admin', true);
-- ... INSERT/UPDATE/DELETE operations
COMMIT;
```

---

## Relationships

### Auth Domain

- `users.role_id` → `roles` (N:1)
- `roles` ←→ `resources` via `role_scopes` (M:N)
- `verification_tokens.user_id` → `users` (N:1)

### Portfolio Domain

- `profile.avatar_file_id` → `storage.files` (1:1)
- `profile.resume_file_id` → `storage.files` (1:1)
- `portfolio_projects.image_file_id` → `storage.files` (1:1)
- `skills.skill_type_id` → `cl_skill_types` (N:1)
- `portfolio_projects` ←→ `skills` via `project_technologies` (M:N)

### Miniatures Domain

- `miniature_themes.cover_image_id` → `storage.files` (1:1)
- `miniature_projects.theme_id` → `miniature_themes` (N:1)
- `miniature_projects` ←→ `cl_techniques` via `miniature_techniques` (M:N)
- `miniature_projects` ←→ `cl_paints` via `miniature_paints` (M:N)
- `miniature_projects` ←→ `storage.files` via `miniature_files` (M:N)

### Messaging Domain

- `delivery_attempts.message_id` → `emails` (N:1)
- `delivery_attempts.recipient_id` → `recipients` (N:1)

## Features

### Audit Logging

- Automatic change tracking via triggers on 13 critical tables
- Captures user context (user_id, username, client_ip)
- JSONB snapshots of before/after data
- Changed fields tracking for UPDATEs

### Query Performance Monitoring

- `pg_stat_statements` extension enabled
- `audit.query_stats` view for easy analysis
- Tracks execution time, call counts, and slow queries

### Automatic Timestamps

- `updated_at` columns auto-update via triggers
- Reusable `public.update_updated_at_column()` function

## Connection Strings

```bash
# DDL operations (migrations)
postgresql://portfolio_owner:portfolio_owner_dev_pass@localhost:5432/portfolio

# API/backend (CRUD operations)
postgresql://portfolio_admin:portfolio_admin_dev_pass@localhost:5432/portfolio

# Messaging worker (messaging schema)
postgresql://portfolio_messaging:portfolio_messaging_dev_pass@localhost:5432/portfolio

# Public/read-only access
postgresql://portfolio_public:portfolio_public_dev_pass@localhost:5432/portfolio
```
