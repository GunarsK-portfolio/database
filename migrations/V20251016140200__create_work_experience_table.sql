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
