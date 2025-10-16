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

-- Add table and column comments
COMMENT ON TABLE portfolio.portfolio_projects IS 'Professional software development portfolio projects';
COMMENT ON COLUMN portfolio.portfolio_projects.id IS 'Unique project identifier';
COMMENT ON COLUMN portfolio.portfolio_projects.title IS 'Project title';
COMMENT ON COLUMN portfolio.portfolio_projects.category IS 'Project category (e.g., Web App, Mobile App, CLI Tool)';
COMMENT ON COLUMN portfolio.portfolio_projects.description IS 'Short project description (1-2 sentences)';
COMMENT ON COLUMN portfolio.portfolio_projects.long_description IS 'Detailed project description (supports markdown)';
COMMENT ON COLUMN portfolio.portfolio_projects.image_file_id IS 'Project screenshot or thumbnail from S3 (references storage.files)';
COMMENT ON COLUMN portfolio.portfolio_projects.github_url IS 'GitHub repository URL';
COMMENT ON COLUMN portfolio.portfolio_projects.live_url IS 'Live demo URL';
COMMENT ON COLUMN portfolio.portfolio_projects.start_date IS 'Project start date';
COMMENT ON COLUMN portfolio.portfolio_projects.end_date IS 'Project end date (NULL if ongoing)';
COMMENT ON COLUMN portfolio.portfolio_projects.is_ongoing IS 'Flag indicating if project is ongoing';
COMMENT ON COLUMN portfolio.portfolio_projects.team_size IS 'Number of team members';
COMMENT ON COLUMN portfolio.portfolio_projects.role IS 'Your role in the project (e.g., Full Stack Developer)';
COMMENT ON COLUMN portfolio.portfolio_projects.featured IS 'Flag to feature this project on homepage/top of list';
COMMENT ON COLUMN portfolio.portfolio_projects.features IS 'Array of key features (JSONB array of strings)';
COMMENT ON COLUMN portfolio.portfolio_projects.challenges IS 'Array of technical challenges faced (JSONB array of strings)';
COMMENT ON COLUMN portfolio.portfolio_projects.learnings IS 'Array of learnings and takeaways (JSONB array of strings)';
COMMENT ON COLUMN portfolio.portfolio_projects.display_order IS 'Display order for sorting projects';
COMMENT ON COLUMN portfolio.portfolio_projects.created_at IS 'Timestamp when project was created';
COMMENT ON COLUMN portfolio.portfolio_projects.updated_at IS 'Timestamp when project was last updated';
