-- Create junction table for miniature techniques
-- Links miniatures to the techniques used in painting them
CREATE TABLE miniatures.miniature_techniques (
    id BIGSERIAL PRIMARY KEY,
    miniature_project_id BIGINT NOT NULL,
    technique_id BIGINT NOT NULL,
    notes TEXT, -- Optional notes about how this technique was applied
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_miniature_project FOREIGN KEY (miniature_project_id)
        REFERENCES miniatures.miniature_projects(id) ON DELETE CASCADE,
    CONSTRAINT fk_technique FOREIGN KEY (technique_id)
        REFERENCES miniatures.cl_techniques(id) ON DELETE CASCADE,
    CONSTRAINT unique_miniature_technique UNIQUE (miniature_project_id, technique_id)
);

-- Create indexes for queries
CREATE INDEX idx_miniature_techniques_miniature_id ON miniatures.miniature_techniques(miniature_project_id);
CREATE INDEX idx_miniature_techniques_technique_id ON miniatures.miniature_techniques(technique_id);

-- Add table and column comments
COMMENT ON TABLE miniatures.miniature_techniques IS 'Junction table linking miniature projects to painting techniques (many-to-many)';
COMMENT ON COLUMN miniatures.miniature_techniques.id IS 'Unique identifier';
COMMENT ON COLUMN miniatures.miniature_techniques.miniature_project_id IS 'Miniature project (references miniatures.miniature_projects)';
COMMENT ON COLUMN miniatures.miniature_techniques.technique_id IS 'Painting technique used (references miniatures.cl_techniques)';
COMMENT ON COLUMN miniatures.miniature_techniques.notes IS 'Optional notes about technique application (e.g., "used for metal armor")';
COMMENT ON COLUMN miniatures.miniature_techniques.created_at IS 'Timestamp when link was created';
