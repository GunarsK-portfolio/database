-- Create portfolio projects table
CREATE TABLE portfolio.portfolio_projects (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    category VARCHAR(100),
    description TEXT,
    long_description TEXT,
    image_file_id BIGINT,
    github_url VARCHAR(255),
    live_url VARCHAR(255),
    start_date DATE,
    end_date DATE,
    is_ongoing BOOLEAN DEFAULT FALSE,
    team_size INT,
    role VARCHAR(100),
    featured BOOLEAN DEFAULT FALSE,
    features JSONB DEFAULT '[]'::jsonb, -- Array of feature strings
    challenges JSONB DEFAULT '[]'::jsonb, -- Array of challenge strings
    learnings JSONB DEFAULT '[]'::jsonb, -- Array of learning strings
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_image_file FOREIGN KEY (image_file_id)
        REFERENCES storage.files(id) ON DELETE SET NULL
);

-- Create indexes
CREATE INDEX idx_portfolio_projects_display_order ON portfolio.portfolio_projects(display_order);
CREATE INDEX idx_portfolio_projects_category ON portfolio.portfolio_projects(category);
CREATE INDEX idx_portfolio_projects_featured ON portfolio.portfolio_projects(featured);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_portfolio_projects_updated_at BEFORE UPDATE ON portfolio.portfolio_projects FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
