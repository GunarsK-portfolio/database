-- Add social media links to profile table
ALTER TABLE portfolio.profile ADD COLUMN github VARCHAR(255);
ALTER TABLE portfolio.profile ADD COLUMN linkedin VARCHAR(255);

-- Add column comments
COMMENT ON COLUMN portfolio.profile.github IS 'GitHub profile URL';
COMMENT ON COLUMN portfolio.profile.linkedin IS 'LinkedIn profile URL';
