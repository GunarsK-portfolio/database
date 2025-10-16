-- Create junction table for miniature paints
-- Links miniatures to the paints used in painting them
CREATE TABLE miniatures.miniature_paints (
    id BIGSERIAL PRIMARY KEY,
    miniature_project_id BIGINT NOT NULL,
    paint_id BIGINT NOT NULL,
    usage_notes TEXT, -- Optional notes about how this paint was used (e.g., "base coat", "highlights")
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_miniature_project FOREIGN KEY (miniature_project_id)
        REFERENCES miniatures.miniature_projects(id) ON DELETE CASCADE,
    CONSTRAINT fk_paint FOREIGN KEY (paint_id)
        REFERENCES miniatures.cl_paints(id) ON DELETE CASCADE,
    CONSTRAINT unique_miniature_paint UNIQUE (miniature_project_id, paint_id)
);

-- Create indexes for queries
CREATE INDEX idx_miniature_paints_miniature_id ON miniatures.miniature_paints(miniature_project_id);
CREATE INDEX idx_miniature_paints_paint_id ON miniatures.miniature_paints(paint_id);

-- Add table and column comments
COMMENT ON TABLE miniatures.miniature_paints IS 'Junction table linking miniature projects to paints (many-to-many)';
COMMENT ON COLUMN miniatures.miniature_paints.id IS 'Unique identifier';
COMMENT ON COLUMN miniatures.miniature_paints.miniature_project_id IS 'Miniature project (references miniatures.miniature_projects)';
COMMENT ON COLUMN miniatures.miniature_paints.paint_id IS 'Paint used (references miniatures.cl_paints)';
COMMENT ON COLUMN miniatures.miniature_paints.usage_notes IS 'Optional notes about paint usage (e.g., "base coat for skin", "highlights")';
COMMENT ON COLUMN miniatures.miniature_paints.created_at IS 'Timestamp when link was created';
