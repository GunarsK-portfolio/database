-- Add CHECK constraints for date validation
-- Ensures end_date is after start_date when both are provided

-- Work experience: end_date must be >= start_date (or NULL for current position)
ALTER TABLE portfolio.work_experience
ADD CONSTRAINT chk_work_experience_dates
CHECK (end_date IS NULL OR end_date >= start_date);

-- Portfolio projects: end_date must be >= start_date (or NULL for ongoing projects)
ALTER TABLE portfolio.portfolio_projects
ADD CONSTRAINT chk_portfolio_projects_dates
CHECK (end_date IS NULL OR end_date >= start_date);

-- Certifications: expiry_date must be > issue_date (or NULL for no expiry)
ALTER TABLE portfolio.certifications
ADD CONSTRAINT chk_certifications_dates
CHECK (expiry_date IS NULL OR expiry_date > issue_date);
