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
