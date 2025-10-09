-- Create miniature projects table
CREATE TABLE miniature_projects (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    completed_date DATE,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on display_order for sorting
CREATE INDEX idx_miniature_projects_display_order ON miniature_projects(display_order);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_miniature_projects_updated_at BEFORE UPDATE ON miniature_projects
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
