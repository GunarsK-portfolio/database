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
        REFERENCES miniatures.miniature_projects(id) ON DELETE CASCADE,
    CONSTRAINT fk_file FOREIGN KEY (file_id)
        REFERENCES storage.files(id) ON DELETE CASCADE,
    CONSTRAINT unique_miniature_file UNIQUE (miniature_project_id, file_id)
);

-- Create indexes for queries
CREATE INDEX idx_miniature_files_miniature_id ON miniatures.miniature_files(miniature_project_id);
CREATE INDEX idx_miniature_files_file_id ON miniatures.miniature_files(file_id);
CREATE INDEX idx_miniature_files_display_order ON miniatures.miniature_files(miniature_project_id, display_order);
