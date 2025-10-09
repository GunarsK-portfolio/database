-- Create work experience table
CREATE TABLE work_experience (
    id BIGSERIAL PRIMARY KEY,
    company VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BOOLEAN DEFAULT FALSE,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on display_order for sorting
CREATE INDEX idx_work_experience_display_order ON work_experience(display_order);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_work_experience_updated_at BEFORE UPDATE ON work_experience
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
