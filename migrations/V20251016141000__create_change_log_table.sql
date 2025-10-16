-- Create audit change log table
CREATE TABLE audit.change_log (
    id BIGSERIAL PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    schema_name VARCHAR(100) NOT NULL,
    record_id BIGINT NOT NULL,
    action VARCHAR(20) NOT NULL, -- INSERT, UPDATE, DELETE
    user_id BIGINT, -- NULL if system/migration change
    username VARCHAR(100), -- Denormalized for easy querying
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSONB, -- Previous values (NULL for INSERT)
    new_data JSONB, -- New values (NULL for DELETE)
    changed_fields TEXT[], -- Array of field names that changed (for UPDATE)
    client_ip VARCHAR(50), -- Optional: for additional context
    user_agent TEXT -- Optional: for additional context
);

-- Indexes for common queries
CREATE INDEX idx_change_log_table_name ON audit.change_log(table_name);
CREATE INDEX idx_change_log_record_id ON audit.change_log(record_id);
CREATE INDEX idx_change_log_user_id ON audit.change_log(user_id);
CREATE INDEX idx_change_log_changed_at ON audit.change_log(changed_at DESC);
CREATE INDEX idx_change_log_action ON audit.change_log(action);

-- Composite index for "show me all changes to this record"
CREATE INDEX idx_change_log_table_record ON audit.change_log(table_name, record_id, changed_at DESC);

-- Composite index for "show me all changes by this user"
CREATE INDEX idx_change_log_user_time ON audit.change_log(user_id, changed_at DESC);

-- Add table and column comments
COMMENT ON TABLE audit.change_log IS 'Audit trail of all data changes in the system';
COMMENT ON COLUMN audit.change_log.id IS 'Unique audit log identifier';
COMMENT ON COLUMN audit.change_log.table_name IS 'Name of the table that was modified';
COMMENT ON COLUMN audit.change_log.schema_name IS 'Schema name (auth, portfolio, miniatures, storage)';
COMMENT ON COLUMN audit.change_log.record_id IS 'ID of the record that was modified';
COMMENT ON COLUMN audit.change_log.action IS 'Action performed: INSERT, UPDATE, or DELETE';
COMMENT ON COLUMN audit.change_log.user_id IS 'User ID who made the change (NULL for system/migration changes)';
COMMENT ON COLUMN audit.change_log.username IS 'Username denormalized for easy querying';
COMMENT ON COLUMN audit.change_log.changed_at IS 'Timestamp when change occurred';
COMMENT ON COLUMN audit.change_log.old_data IS 'JSONB snapshot of record before change (NULL for INSERT)';
COMMENT ON COLUMN audit.change_log.new_data IS 'JSONB snapshot of record after change (NULL for DELETE)';
COMMENT ON COLUMN audit.change_log.changed_fields IS 'Array of field names that were modified (UPDATE only)';
COMMENT ON COLUMN audit.change_log.client_ip IS 'Optional: client IP address for additional context';
COMMENT ON COLUMN audit.change_log.user_agent IS 'Optional: client user agent for additional context';
