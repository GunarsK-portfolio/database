-- Create images table
CREATE TABLE images (
    id BIGSERIAL PRIMARY KEY,
    miniature_project_id BIGINT REFERENCES miniature_projects(id) ON DELETE CASCADE,
    title VARCHAR(200),
    description TEXT,
    s3_key VARCHAR(500) NOT NULL,
    s3_bucket VARCHAR(100) NOT NULL,
    url VARCHAR(500) NOT NULL,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on miniature_project_id for faster joins
CREATE INDEX idx_images_miniature_project_id ON images(miniature_project_id);

-- Create index on display_order for sorting
CREATE INDEX idx_images_display_order ON images(display_order);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_images_updated_at BEFORE UPDATE ON images
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
