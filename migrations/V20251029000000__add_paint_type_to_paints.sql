ALTER TABLE miniatures.cl_paints
ADD COLUMN paint_type VARCHAR(50) NOT NULL
CHECK (paint_type IN (
    'Base',
    'Layer',
    'Shade',
    'Wash',
    'Contrast',
    'Dry',
    'Technical',
    'Metallic',
    'Air',
    'Primer',
    'Edge',
    'Glaze',
    'Ink'
));

-- Add index for paint_type
CREATE INDEX idx_paints_paint_type ON miniatures.cl_paints (paint_type);

-- Add column comment
COMMENT ON COLUMN miniatures.cl_paints.paint_type IS 'Type of paint: Base, Layer, Shade, Wash, Contrast, Dry, Technical, Metallic, Air, Primer, Edge, Glaze, Ink';
