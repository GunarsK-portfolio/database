-- Create paints reference table
-- Master list of miniature paints
CREATE TABLE miniatures.cl_paints (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL,
    color_hex VARCHAR(7), -- e.g., '#FF5733'
    paint_type VARCHAR(50), -- 'Acrylic', 'Enamel', 'Oil', 'Wash', 'Shade', 'Contrast', etc.
    finish VARCHAR(50), -- 'Matte', 'Satin', 'Gloss', 'Metallic'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_paint UNIQUE (name, manufacturer)
);

-- Create indexes
CREATE INDEX idx_paints_manufacturer ON miniatures.cl_paints(manufacturer);
CREATE INDEX idx_paints_paint_type ON miniatures.cl_paints(paint_type);
CREATE INDEX idx_paints_name ON miniatures.cl_paints(name);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_paints_updated_at BEFORE UPDATE ON miniatures.cl_paints FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
