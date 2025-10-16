-- Add audit triggers to critical tables
-- These triggers will automatically log all INSERT/UPDATE/DELETE operations

-- Portfolio schema tables (user-managed content)
CREATE TRIGGER audit_profile
    AFTER INSERT OR UPDATE OR DELETE ON portfolio.profile
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_work_experience
    AFTER INSERT OR UPDATE OR DELETE ON portfolio.work_experience
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_certifications
    AFTER INSERT OR UPDATE OR DELETE ON portfolio.certifications
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_portfolio_projects
    AFTER INSERT OR UPDATE OR DELETE ON portfolio.portfolio_projects
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_skills
    AFTER INSERT OR UPDATE OR DELETE ON portfolio.skills
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_project_technologies
    AFTER INSERT OR UPDATE OR DELETE ON portfolio.project_technologies
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

-- Miniatures schema tables (user-managed content)
CREATE TRIGGER audit_miniature_themes
    AFTER INSERT OR UPDATE OR DELETE ON miniatures.miniature_themes
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_miniature_projects
    AFTER INSERT OR UPDATE OR DELETE ON miniatures.miniature_projects
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_miniature_techniques
    AFTER INSERT OR UPDATE OR DELETE ON miniatures.miniature_techniques
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_miniature_paints
    AFTER INSERT OR UPDATE OR DELETE ON miniatures.miniature_paints
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

CREATE TRIGGER audit_miniature_files
    AFTER INSERT OR UPDATE OR DELETE ON miniatures.miniature_files
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

-- Storage schema tables (file management)
CREATE TRIGGER audit_files
    AFTER INSERT OR UPDATE OR DELETE ON storage.files
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

-- Auth schema tables (user management)
CREATE TRIGGER audit_users
    AFTER INSERT OR UPDATE OR DELETE ON auth.users
    FOR EACH ROW EXECUTE FUNCTION audit.log_change();

-- Note: Classifier tables (cl_*) are intentionally NOT audited
-- They rarely change and are typically managed through migrations or admin tools
-- If you want to audit them later, add triggers like:
-- CREATE TRIGGER audit_cl_techniques
--     AFTER INSERT OR UPDATE OR DELETE ON miniatures.cl_techniques
--     FOR EACH ROW EXECUTE FUNCTION audit.log_change();
