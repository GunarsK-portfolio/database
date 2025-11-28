-- Create recipients table for managing email recipients
CREATE TABLE messaging.recipients (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create index for active recipients lookup
CREATE INDEX idx_recipients_is_active ON messaging.recipients (is_active);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_recipients_updated_at
    BEFORE UPDATE ON messaging.recipients
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE messaging.recipients IS 'Email recipients for contact form notifications';
COMMENT ON COLUMN messaging.recipients.id IS 'Unique recipient identifier';
COMMENT ON COLUMN messaging.recipients.email IS 'Recipient email address';
COMMENT ON COLUMN messaging.recipients.name IS 'Recipient display name';
COMMENT ON COLUMN messaging.recipients.is_active IS 'Whether recipient should receive emails';
COMMENT ON COLUMN messaging.recipients.created_at IS 'Timestamp when recipient was added';
COMMENT ON COLUMN messaging.recipients.updated_at IS 'Timestamp when recipient was last updated';
