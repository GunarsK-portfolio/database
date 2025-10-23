-- Create miniature themes table
CREATE TABLE miniatures.miniature_themes (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cover_image_id BIGINT,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_theme_name UNIQUE (name),
    CONSTRAINT fk_cover_image FOREIGN KEY (cover_image_id)
    REFERENCES storage.files (id) ON DELETE SET NULL
);

-- Create index on display_order for sorting
CREATE INDEX idx_miniature_themes_display_order ON miniatures.miniature_themes (
    display_order
);

-- Create index on cover_image_id for joins
CREATE INDEX idx_miniature_themes_cover_image_id ON miniatures.miniature_themes (
    cover_image_id
);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_miniature_themes_updated_at BEFORE UPDATE ON miniatures.miniature_themes FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE miniatures.miniature_themes IS 'Thematic collections of miniature projects (e.g., Stormlight Archive, Warhammer 40k)';
COMMENT ON COLUMN miniatures.miniature_themes.id IS 'Unique theme identifier';
COMMENT ON COLUMN miniatures.miniature_themes.name IS 'Theme name (e.g., Stormlight Archive)';
COMMENT ON COLUMN miniatures.miniature_themes.description IS 'Theme description (supports markdown)';
COMMENT ON COLUMN miniatures.miniature_themes.cover_image_id IS 'Cover image from S3 (references storage.files)';
COMMENT ON COLUMN miniatures.miniature_themes.display_order IS 'Display order for sorting themes';
COMMENT ON COLUMN miniatures.miniature_themes.created_at IS 'Timestamp when theme was created';
COMMENT ON COLUMN miniatures.miniature_themes.updated_at IS 'Timestamp when theme was last updated';
