-- Create techniques reference table
-- Master list of miniature painting techniques
CREATE TABLE miniatures.cl_techniques (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    difficulty_level VARCHAR(50), -- 'Beginner', 'Intermediate', 'Advanced', 'Expert'
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_techniques_name ON miniatures.cl_techniques(name);
CREATE INDEX idx_techniques_difficulty ON miniatures.cl_techniques(difficulty_level);
CREATE INDEX idx_techniques_display_order ON miniatures.cl_techniques(display_order);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_techniques_updated_at BEFORE UPDATE ON miniatures.cl_techniques FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
