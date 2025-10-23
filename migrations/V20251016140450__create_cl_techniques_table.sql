-- Create techniques reference table
-- Master list of miniature painting techniques
CREATE TABLE miniatures.cl_techniques (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    -- 'Beginner', 'Intermediate', 'Advanced', 'Expert'
    difficulty_level VARCHAR(50),
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_techniques_name ON miniatures.cl_techniques (name);
CREATE INDEX idx_techniques_difficulty ON miniatures.cl_techniques (
    difficulty_level
);
CREATE INDEX idx_techniques_display_order ON miniatures.cl_techniques (
    display_order
);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_techniques_updated_at BEFORE UPDATE ON miniatures.cl_techniques FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE miniatures.cl_techniques IS 'Master list of miniature painting techniques (classifier)';
COMMENT ON COLUMN miniatures.cl_techniques.id IS 'Unique technique identifier';
COMMENT ON COLUMN miniatures.cl_techniques.name IS 'Technique name (e.g., Drybrushing, NMM, Wet Blending)';
COMMENT ON COLUMN miniatures.cl_techniques.description IS 'Technique description and usage notes';
COMMENT ON COLUMN miniatures.cl_techniques.difficulty_level IS 'Difficulty: Beginner, Intermediate, Advanced, Expert';
COMMENT ON COLUMN miniatures.cl_techniques.display_order IS 'Display order for sorting techniques';
COMMENT ON COLUMN miniatures.cl_techniques.created_at IS 'Timestamp when technique was created';
COMMENT ON COLUMN miniatures.cl_techniques.updated_at IS 'Timestamp when technique was last updated';
