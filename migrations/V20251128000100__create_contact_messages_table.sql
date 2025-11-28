-- Create contact_messages table for storing contact form submissions
CREATE TABLE messaging.contact_messages (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    subject VARCHAR(500) NOT NULL,
    message TEXT NOT NULL,
    honeypot VARCHAR(255),
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    attempts INT NOT NULL DEFAULT 0,
    last_error TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    sent_at TIMESTAMPTZ
);

-- Create indexes for common queries
CREATE INDEX idx_contact_messages_status ON messaging.contact_messages (status);
CREATE INDEX idx_contact_messages_created_at ON messaging.contact_messages (created_at);
CREATE INDEX idx_contact_messages_email ON messaging.contact_messages (email);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_contact_messages_updated_at
    BEFORE UPDATE ON messaging.contact_messages
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add check constraint for valid status values
ALTER TABLE messaging.contact_messages
    ADD CONSTRAINT chk_contact_messages_status
    CHECK (status IN ('pending', 'queued', 'sent', 'failed'));

-- Add table and column comments
COMMENT ON TABLE messaging.contact_messages IS 'Contact form submissions from public website';
COMMENT ON COLUMN messaging.contact_messages.id IS 'Unique message identifier';
COMMENT ON COLUMN messaging.contact_messages.name IS 'Sender name';
COMMENT ON COLUMN messaging.contact_messages.email IS 'Sender email address';
COMMENT ON COLUMN messaging.contact_messages.subject IS 'Message subject';
COMMENT ON COLUMN messaging.contact_messages.message IS 'Message content';
COMMENT ON COLUMN messaging.contact_messages.honeypot IS 'Bot detection field - should be empty for legitimate submissions';
COMMENT ON COLUMN messaging.contact_messages.status IS 'Message status: pending, queued, sent, failed';
COMMENT ON COLUMN messaging.contact_messages.attempts IS 'Number of delivery attempts';
COMMENT ON COLUMN messaging.contact_messages.last_error IS 'Last error message if delivery failed';
COMMENT ON COLUMN messaging.contact_messages.created_at IS 'Timestamp when message was submitted';
COMMENT ON COLUMN messaging.contact_messages.updated_at IS 'Timestamp when message was last updated';
COMMENT ON COLUMN messaging.contact_messages.sent_at IS 'Timestamp when message was successfully sent';
