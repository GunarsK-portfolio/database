-- Create delivery_attempts table for tracking email delivery audit trail
CREATE TABLE messaging.delivery_attempts (
    id BIGSERIAL PRIMARY KEY,
    message_id BIGINT NOT NULL REFERENCES messaging.contact_messages(id) ON DELETE CASCADE,
    recipient_email VARCHAR(255) NOT NULL,
    status VARCHAR(20) NOT NULL,
    error_code VARCHAR(100),
    error_message TEXT,
    attempted_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create indexes for common queries
CREATE INDEX idx_delivery_attempts_message_id ON messaging.delivery_attempts (message_id);
CREATE INDEX idx_delivery_attempts_status ON messaging.delivery_attempts (status);
CREATE INDEX idx_delivery_attempts_attempted_at ON messaging.delivery_attempts (attempted_at);

-- Add check constraint for valid status values
ALTER TABLE messaging.delivery_attempts
    ADD CONSTRAINT chk_delivery_attempts_status
    CHECK (status IN ('success', 'failed'));

-- Add table and column comments
COMMENT ON TABLE messaging.delivery_attempts IS 'Audit trail for email delivery attempts';
COMMENT ON COLUMN messaging.delivery_attempts.id IS 'Unique attempt identifier';
COMMENT ON COLUMN messaging.delivery_attempts.message_id IS 'Reference to contact message';
COMMENT ON COLUMN messaging.delivery_attempts.recipient_email IS 'Email address of recipient';
COMMENT ON COLUMN messaging.delivery_attempts.status IS 'Delivery status: success, failed';
COMMENT ON COLUMN messaging.delivery_attempts.error_code IS 'SES error code if delivery failed';
COMMENT ON COLUMN messaging.delivery_attempts.error_message IS 'Detailed error message if delivery failed';
COMMENT ON COLUMN messaging.delivery_attempts.attempted_at IS 'Timestamp of delivery attempt';
