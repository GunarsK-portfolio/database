-- Add audit triggers to messaging schema tables
-- These triggers automatically log INSERT/UPDATE/DELETE operations to audit.change_log

-- Recipients table (admin-managed, critical for audit trail)
CREATE TRIGGER audit_recipients
AFTER INSERT OR UPDATE OR DELETE ON messaging.recipients
FOR EACH ROW EXECUTE FUNCTION audit.log_change();

-- Contact messages table (track status changes, delivery attempts)
CREATE TRIGGER audit_contact_messages
AFTER INSERT OR UPDATE OR DELETE ON messaging.contact_messages
FOR EACH ROW EXECUTE FUNCTION audit.log_change();

-- Note: delivery_attempts is intentionally NOT audited
-- It's append-only diagnostic data, not user-managed content
