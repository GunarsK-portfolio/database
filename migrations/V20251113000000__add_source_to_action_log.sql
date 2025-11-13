-- Add source column to audit.action_log to track which application originated the action
-- Values: 'admin-web', 'public-web', 'admin-api', 'public-api', 'auth-service', 'files-api', etc.

ALTER TABLE audit.action_log
ADD COLUMN source VARCHAR(50);

-- Create index for efficient source-based queries
CREATE INDEX idx_action_log_source ON audit.action_log (source);

-- Add comment
COMMENT ON COLUMN audit.action_log.source IS 'Source application that initiated the action (admin-web, public-web, etc.)';
