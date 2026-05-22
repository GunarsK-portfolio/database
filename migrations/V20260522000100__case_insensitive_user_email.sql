-- Make user email uniqueness and lookups case-insensitive.
--
-- Login and all email lookups compare LOWER(email) = LOWER(?), but the table
-- only had case-sensitive indexes on the raw column, so the DB still permitted
-- case-variant duplicate emails. Replace them with a unique functional index on
-- LOWER(email): it enforces case-insensitive uniqueness and backs the lookups.
--
-- Fails if case-variant duplicate emails already exist; resolve them first.

-- Redundant with the unique constraint below; both are plain btrees on raw email.
DROP INDEX IF EXISTS auth.idx_users_email;

-- Replace the case-sensitive unique constraint with a case-insensitive index.
ALTER TABLE auth.users
DROP CONSTRAINT IF EXISTS users_email_key;

CREATE UNIQUE INDEX idx_users_email_lower ON auth.users (lower(email));

COMMENT ON INDEX auth.idx_users_email_lower IS 'Enforces case-insensitive email uniqueness and backs LOWER(email) lookups';
