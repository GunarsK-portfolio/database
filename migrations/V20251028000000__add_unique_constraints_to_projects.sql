-- Add unique constraints to project tables for seed data idempotency

-- Add unique constraint to portfolio_projects.title
ALTER TABLE portfolio.portfolio_projects
ADD CONSTRAINT unique_portfolio_project_title UNIQUE (title);

-- Add unique constraint to miniature_projects.title
ALTER TABLE miniatures.miniature_projects
ADD CONSTRAINT unique_miniature_project_title UNIQUE (title);

-- Add comments
COMMENT ON CONSTRAINT unique_portfolio_project_title ON portfolio.portfolio_projects IS 'Ensures portfolio project titles are unique';
COMMENT ON CONSTRAINT unique_miniature_project_title ON miniatures.miniature_projects IS 'Ensures miniature project titles are unique';
