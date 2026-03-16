-- Add email verification status and display name to users
ALTER TABLE auth.users
ADD COLUMN email_verified BOOLEAN;

-- Service accounts are trusted; mark svc-auth as verified
UPDATE auth.users
SET email_verified = TRUE
WHERE username = 'svc-auth';

-- Set remaining users to unverified, then enforce NOT NULL + default
UPDATE auth.users
SET email_verified = FALSE
WHERE email_verified IS NULL;

ALTER TABLE auth.users
ALTER COLUMN email_verified SET NOT NULL,
ALTER COLUMN email_verified SET DEFAULT FALSE;

ALTER TABLE auth.users
ADD COLUMN display_name VARCHAR(100);

COMMENT ON COLUMN auth.users.email_verified IS 'Whether the user has verified their email address';
COMMENT ON COLUMN auth.users.display_name IS 'User-chosen display name (optional)';
