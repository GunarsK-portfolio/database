-- Create junction table for miniature project files (images)
-- Allows multiple images per miniature with ordering and captions
CREATE TABLE miniatures.miniature_files (
    id BIGSERIAL PRIMARY KEY,
    miniature_project_id BIGINT NOT NULL,
    file_id BIGINT NOT NULL,
    caption TEXT,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_miniature_project FOREIGN KEY (miniature_project_id)
    REFERENCES miniatures.miniature_projects (id) ON DELETE CASCADE,
    CONSTRAINT fk_file FOREIGN KEY (file_id)
    REFERENCES storage.files (id) ON DELETE CASCADE,
    CONSTRAINT unique_miniature_file UNIQUE (miniature_project_id, file_id)
);

-- Create indexes for queries
CREATE INDEX idx_miniature_files_miniature_id ON miniatures.miniature_files (
    miniature_project_id
);
CREATE INDEX idx_miniature_files_file_id ON miniatures.miniature_files (
    file_id
);
CREATE INDEX idx_miniature_files_display_order ON miniatures.miniature_files (
    miniature_project_id, display_order
);

-- Add table and column comments
COMMENT ON TABLE miniatures.miniature_files IS 'Junction table linking miniature projects to images (many-to-many)';
COMMENT ON COLUMN miniatures.miniature_files.id IS 'Unique identifier';
COMMENT ON COLUMN miniatures.miniature_files.miniature_project_id IS 'Miniature project (references miniatures.miniature_projects)';
COMMENT ON COLUMN miniatures.miniature_files.file_id IS 'Image file from S3 (references storage.files)';
COMMENT ON COLUMN miniatures.miniature_files.caption IS 'Optional image caption';
COMMENT ON COLUMN miniatures.miniature_files.display_order IS 'Order for displaying images in gallery';
COMMENT ON COLUMN miniatures.miniature_files.created_at IS 'Timestamp when link was created';
