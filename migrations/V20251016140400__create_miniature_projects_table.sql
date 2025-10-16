-- Create miniature projects table
CREATE TABLE miniatures.miniature_projects (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    completed_date DATE,
    scale VARCHAR(50),
    manufacturer VARCHAR(100),
    time_spent NUMERIC(6,2), -- Hours (e.g., 12.5 hours)
    difficulty VARCHAR(50),
    theme_id BIGINT,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_miniature_theme FOREIGN KEY (theme_id)
        REFERENCES miniatures.miniature_themes(id) ON DELETE SET NULL
);

-- Create indexes
CREATE INDEX idx_miniature_projects_display_order ON miniatures.miniature_projects(display_order);
CREATE INDEX idx_miniature_projects_theme_id ON miniatures.miniature_projects(theme_id);
CREATE INDEX idx_miniature_projects_difficulty ON miniatures.miniature_projects(difficulty);
CREATE INDEX idx_miniature_projects_manufacturer ON miniatures.miniature_projects(manufacturer);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_miniature_projects_updated_at BEFORE UPDATE ON miniatures.miniature_projects FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE miniatures.miniature_projects IS 'Individual miniature painting projects';
COMMENT ON COLUMN miniatures.miniature_projects.id IS 'Unique project identifier';
COMMENT ON COLUMN miniatures.miniature_projects.title IS 'Project title (e.g., Kaladin Stormblessed)';
COMMENT ON COLUMN miniatures.miniature_projects.description IS 'Project description, techniques used, notes (supports markdown)';
COMMENT ON COLUMN miniatures.miniature_projects.completed_date IS 'Date when project was completed';
COMMENT ON COLUMN miniatures.miniature_projects.scale IS 'Miniature scale (e.g., 28mm, 1:35, 75mm)';
COMMENT ON COLUMN miniatures.miniature_projects.manufacturer IS 'Manufacturer or sculptor (e.g., Games Workshop, Reaper)';
COMMENT ON COLUMN miniatures.miniature_projects.time_spent IS 'Hours spent on project (e.g., 12.5)';
COMMENT ON COLUMN miniatures.miniature_projects.difficulty IS 'Difficulty level (Beginner, Intermediate, Advanced, Expert)';
COMMENT ON COLUMN miniatures.miniature_projects.theme_id IS 'Theme this project belongs to (references miniatures.miniature_themes)';
COMMENT ON COLUMN miniatures.miniature_projects.display_order IS 'Display order within theme';
COMMENT ON COLUMN miniatures.miniature_projects.created_at IS 'Timestamp when project was created';
COMMENT ON COLUMN miniatures.miniature_projects.updated_at IS 'Timestamp when project was last updated';
