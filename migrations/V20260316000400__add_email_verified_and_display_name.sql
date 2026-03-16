-- Add email verification status and display name to users
ALTER TABLE auth.users
ADD COLUMN email_verified BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE auth.users
ADD COLUMN display_name VARCHAR(100);

COMMENT ON COLUMN auth.users.email_verified IS 'Whether the user has verified their email address';
COMMENT ON COLUMN auth.users.display_name IS 'User-chosen display name (optional)';
