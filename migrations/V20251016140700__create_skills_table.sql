-- Create skills table
-- Note: Skills can be attached to projects even if is_visible = FALSE
-- This allows tracking technologies used in projects without showing them in the skills section
CREATE TABLE portfolio.skills (
    id BIGSERIAL PRIMARY KEY,
    skill VARCHAR(100) NOT NULL,
    skill_type_id BIGINT NOT NULL,
    is_visible BOOLEAN DEFAULT TRUE, -- Show in skills section
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_skill UNIQUE (skill),
    CONSTRAINT fk_skill_type FOREIGN KEY (skill_type_id)
    REFERENCES portfolio.cl_skill_types (id) ON DELETE RESTRICT
);

-- Create index on skill_type_id for filtering by category
CREATE INDEX idx_skills_type_id ON portfolio.skills (skill_type_id);

-- Create index on is_visible for filtering visible skills
CREATE INDEX idx_skills_is_visible ON portfolio.skills (is_visible);

-- Create index on display_order for sorting
CREATE INDEX idx_skills_display_order ON portfolio.skills (display_order);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_skills_updated_at BEFORE UPDATE ON portfolio.skills FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE portfolio.skills IS 'Individual skills and technologies';
COMMENT ON COLUMN portfolio.skills.id IS 'Unique skill identifier';
COMMENT ON COLUMN portfolio.skills.skill IS 'Skill or technology name (e.g., React, PostgreSQL, Docker)';
COMMENT ON COLUMN portfolio.skills.skill_type_id IS 'Skill category (references portfolio.cl_skill_types)';
COMMENT ON COLUMN portfolio.skills.is_visible IS 'Show in skills section (FALSE allows tracking project tech without displaying)';
COMMENT ON COLUMN portfolio.skills.display_order IS 'Display order within skill type';
COMMENT ON COLUMN portfolio.skills.created_at IS 'Timestamp when skill was created';
COMMENT ON COLUMN portfolio.skills.updated_at IS 'Timestamp when skill was last updated';
