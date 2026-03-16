-- Generalize contact_messages into a shared emails table for all services
-- (contact forms, auth verification, password reset, 2FA)

-- Rename table
ALTER TABLE messaging.contact_messages RENAME TO emails;

-- Add type column (all existing rows are contact form submissions)
ALTER TABLE messaging.emails
ADD COLUMN type VARCHAR(50) NOT NULL DEFAULT 'contact_form';

-- Add direct recipient column (auth emails go to a specific address;
-- contact forms use the recipients table instead)
ALTER TABLE messaging.emails
ADD COLUMN recipient_email VARCHAR(255);

-- Make contact-form-specific columns nullable for non-contact email types
ALTER TABLE messaging.emails
ALTER COLUMN name DROP NOT NULL;

ALTER TABLE messaging.emails
ALTER COLUMN email DROP NOT NULL;

-- Replace email format constraint to allow NULL
ALTER TABLE messaging.emails
DROP CONSTRAINT chk_contact_messages_email_format;

ALTER TABLE messaging.emails
ADD CONSTRAINT chk_emails_email_format
CHECK (email IS NULL OR email ~ '^[^@\s]+@[^@\s]+\.[^@\s]+$');

-- Ensure every email has at least one target
-- (sender email for contact forms, recipient_email for auth emails)
ALTER TABLE messaging.emails
ADD CONSTRAINT chk_emails_has_target
CHECK (email IS NOT NULL OR recipient_email IS NOT NULL);

-- Replace status constraint (same values, new name)
ALTER TABLE messaging.emails
DROP CONSTRAINT chk_contact_messages_status;

ALTER TABLE messaging.emails
ADD CONSTRAINT chk_emails_status
CHECK (status IN ('pending', 'queued', 'sent', 'failed'));

-- Add recipient_email format constraint
ALTER TABLE messaging.emails
ADD CONSTRAINT chk_emails_recipient_email_format
CHECK (
    recipient_email IS NULL
    OR recipient_email ~ '^[^@\s]+@[^@\s]+\.[^@\s]+$'
);

-- Add type check constraint (includes future types to avoid extra migrations)
ALTER TABLE messaging.emails
ADD CONSTRAINT chk_emails_type
CHECK (type IN ('contact_form', 'email_verification', 'password_reset', '2fa_code'));

-- Rename existing indexes
ALTER INDEX messaging.idx_contact_messages_status RENAME TO idx_emails_status;
ALTER INDEX messaging.idx_contact_messages_created_at RENAME TO idx_emails_created_at;
ALTER INDEX messaging.idx_contact_messages_email RENAME TO idx_emails_email;

-- Add new indexes
CREATE INDEX idx_emails_type ON messaging.emails (type);
CREATE INDEX idx_emails_recipient_email ON messaging.emails (recipient_email);

-- Rename delivery_attempts FK constraint
ALTER TABLE messaging.delivery_attempts
RENAME CONSTRAINT delivery_attempts_message_id_fkey
TO delivery_attempts_email_id_fkey;

-- Rename updated_at trigger
ALTER TRIGGER update_contact_messages_updated_at ON messaging.emails
RENAME TO update_emails_updated_at;

-- Replace audit trigger (can't rename, must drop + recreate)
DROP TRIGGER audit_contact_messages ON messaging.emails;

CREATE TRIGGER audit_emails
AFTER INSERT OR UPDATE OR DELETE ON messaging.emails
FOR EACH ROW EXECUTE FUNCTION audit.log_change();

-- Update comments
COMMENT ON TABLE messaging.emails IS 'Email messages for all services (contact forms, auth verification, password reset, 2FA)';
COMMENT ON COLUMN messaging.emails.type IS 'Email type: contact_form, email_verification, password_reset, 2fa_code';
COMMENT ON COLUMN messaging.emails.recipient_email IS 'Direct recipient email (for auth emails). Contact forms use recipients table instead.';
