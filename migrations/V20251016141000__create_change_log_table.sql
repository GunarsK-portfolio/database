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

COMMENT ON TABLE audit.change_log IS 'Audit trail of all data changes in the system';
COMMENT ON COLUMN audit.change_log.old_data IS 'JSONB snapshot of record before change (NULL for INSERT)';
COMMENT ON COLUMN audit.change_log.new_data IS 'JSONB snapshot of record after change (NULL for DELETE)';
COMMENT ON COLUMN audit.change_log.changed_fields IS 'Array of field names that were modified (UPDATE only)';
