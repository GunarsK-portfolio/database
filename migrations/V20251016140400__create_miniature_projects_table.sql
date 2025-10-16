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
