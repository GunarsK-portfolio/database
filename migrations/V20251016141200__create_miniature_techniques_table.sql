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
