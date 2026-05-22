-- Make username uniqueness and lookups case-insensitive.
--
-- Login matches LOWER(username) = LOWER(?), mirroring the email change, but the
-- table only had case-sensitive indexes on the raw column, so the DB still
-- permitted case-variant duplicate usernames. Replace them with a unique
-- functional index on LOWER(username): it enforces case-insensitive uniqueness
-- and backs the lookups.
--
-- Fails if case-variant duplicate usernames already exist; resolve them first.

-- Redundant with the unique constraint below; both are plain btrees on raw username.
DROP INDEX IF EXISTS auth.idx_users_username;

-- Replace the case-sensitive unique constraint with a case-insensitive index.
ALTER TABLE auth.users
DROP CONSTRAINT IF EXISTS users_username_key;

CREATE UNIQUE INDEX idx_users_username_lower ON auth.users (lower(username));

COMMENT ON INDEX auth.idx_users_username_lower IS 'Enforces case-insensitive username uniqueness and backs LOWER(username) lookups';
