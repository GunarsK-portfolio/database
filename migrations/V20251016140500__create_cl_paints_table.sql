-- Create paints reference table
-- Master list of miniature paints
CREATE TABLE miniatures.cl_paints (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL,
    color_hex VARCHAR(7), -- e.g., '#FF5733'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_paint UNIQUE (name, manufacturer)
);

-- Create indexes
CREATE INDEX idx_paints_manufacturer ON miniatures.cl_paints(manufacturer);
CREATE INDEX idx_paints_name ON miniatures.cl_paints(name);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_paints_updated_at BEFORE UPDATE ON miniatures.cl_paints FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE miniatures.cl_paints IS 'Master list of miniature paints (classifier)';
COMMENT ON COLUMN miniatures.cl_paints.id IS 'Unique paint identifier';
COMMENT ON COLUMN miniatures.cl_paints.name IS 'Paint name (e.g., Abaddon Black, Ushabti Bone)';
COMMENT ON COLUMN miniatures.cl_paints.manufacturer IS 'Manufacturer (e.g., AK Interactive, Army Painter)';
COMMENT ON COLUMN miniatures.cl_paints.color_hex IS 'Hex color code for display (e.g., #FF5733)';
COMMENT ON COLUMN miniatures.cl_paints.created_at IS 'Timestamp when paint was created';
COMMENT ON COLUMN miniatures.cl_paints.updated_at IS 'Timestamp when paint was last updated';
