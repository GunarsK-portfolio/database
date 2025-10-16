-- Create skill types classifier table
CREATE TABLE portfolio.cl_skill_types (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_skill_types_display_order ON portfolio.cl_skill_types(display_order);
CREATE INDEX idx_skill_types_name ON portfolio.cl_skill_types(name);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_skill_types_updated_at BEFORE UPDATE ON portfolio.cl_skill_types FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE portfolio.cl_skill_types IS 'Skill categories classifier (e.g., Frontend, Backend, Database, DevOps)';
COMMENT ON COLUMN portfolio.cl_skill_types.id IS 'Unique skill type identifier';
COMMENT ON COLUMN portfolio.cl_skill_types.name IS 'Skill type name (e.g., Frontend, Backend, Database, DevOps)';
COMMENT ON COLUMN portfolio.cl_skill_types.description IS 'Skill type description';
COMMENT ON COLUMN portfolio.cl_skill_types.display_order IS 'Display order for sorting skill types';
COMMENT ON COLUMN portfolio.cl_skill_types.created_at IS 'Timestamp when skill type was created';
COMMENT ON COLUMN portfolio.cl_skill_types.updated_at IS 'Timestamp when skill type was last updated';
