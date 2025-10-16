-- Create project_technologies junction table
-- Links portfolio projects to skills (many-to-many relationship)
CREATE TABLE portfolio.project_technologies (
    id BIGSERIAL PRIMARY KEY,
    project_id BIGINT NOT NULL,
    skill_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_project FOREIGN KEY (project_id)
        REFERENCES portfolio.portfolio_projects(id) ON DELETE CASCADE,
    CONSTRAINT fk_skill FOREIGN KEY (skill_id)
        REFERENCES portfolio.skills(id) ON DELETE CASCADE,
    CONSTRAINT unique_project_skill UNIQUE (project_id, skill_id)
);

-- Create indexes for efficient lookups
CREATE INDEX idx_project_technologies_project_id ON portfolio.project_technologies(project_id);
CREATE INDEX idx_project_technologies_skill_id ON portfolio.project_technologies(skill_id);

-- Add table and column comments
COMMENT ON TABLE portfolio.project_technologies IS 'Junction table linking portfolio projects to skills/technologies (many-to-many)';
COMMENT ON COLUMN portfolio.project_technologies.id IS 'Unique identifier';
COMMENT ON COLUMN portfolio.project_technologies.project_id IS 'Portfolio project (references portfolio.portfolio_projects)';
COMMENT ON COLUMN portfolio.project_technologies.skill_id IS 'Skill or technology used (references portfolio.skills)';
COMMENT ON COLUMN portfolio.project_technologies.created_at IS 'Timestamp when link was created';
