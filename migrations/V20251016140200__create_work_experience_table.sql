-- Create work experience table
CREATE TABLE portfolio.work_experience (
    id BIGSERIAL PRIMARY KEY,
    company VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on start_date for sorting (most recent first)
CREATE INDEX idx_work_experience_start_date ON portfolio.work_experience(start_date DESC);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_work_experience_updated_at BEFORE UPDATE ON portfolio.work_experience FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE portfolio.work_experience IS 'Work experience history for portfolio owner';
COMMENT ON COLUMN portfolio.work_experience.id IS 'Unique work experience identifier';
COMMENT ON COLUMN portfolio.work_experience.company IS 'Company or organization name';
COMMENT ON COLUMN portfolio.work_experience.position IS 'Job title or position';
COMMENT ON COLUMN portfolio.work_experience.description IS 'Job responsibilities and achievements (supports markdown)';
COMMENT ON COLUMN portfolio.work_experience.start_date IS 'Employment start date';
COMMENT ON COLUMN portfolio.work_experience.end_date IS 'Employment end date (NULL if current position)';
COMMENT ON COLUMN portfolio.work_experience.is_current IS 'Flag indicating if this is the current position';
COMMENT ON COLUMN portfolio.work_experience.created_at IS 'Timestamp when record was created';
COMMENT ON COLUMN portfolio.work_experience.updated_at IS 'Timestamp when record was last updated';
