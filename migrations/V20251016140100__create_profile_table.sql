-- Create profile table
CREATE TABLE portfolio.profile (
    id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    title VARCHAR(100),
    bio TEXT,
    email VARCHAR(100),
    phone VARCHAR(20),
    location VARCHAR(100),
    avatar_file_id BIGINT,
    resume_file_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_avatar_file FOREIGN KEY (avatar_file_id)
    REFERENCES storage.files (id) ON DELETE SET NULL,
    CONSTRAINT fk_resume_file FOREIGN KEY (resume_file_id)
    REFERENCES storage.files (id) ON DELETE SET NULL
);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_profile_updated_at BEFORE UPDATE ON portfolio.profile
FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE portfolio.profile IS 'Portfolio owner profile information (singleton table, should have exactly 1 row)';
COMMENT ON COLUMN portfolio.profile.id IS 'Unique profile identifier';
COMMENT ON COLUMN portfolio.profile.full_name IS 'Full name of portfolio owner';
COMMENT ON COLUMN portfolio.profile.title IS 'Professional title or headline';
COMMENT ON COLUMN portfolio.profile.bio IS 'Biography or about section (supports markdown)';
COMMENT ON COLUMN portfolio.profile.email IS 'Public contact email address';
COMMENT ON COLUMN portfolio.profile.phone IS 'Public contact phone number';
COMMENT ON COLUMN portfolio.profile.location IS 'Current location (e.g., City, Country)';
COMMENT ON COLUMN portfolio.profile.avatar_file_id IS 'Profile photo stored in S3 (references storage.files)';
COMMENT ON COLUMN portfolio.profile.resume_file_id IS 'Resume PDF stored in S3 (references storage.files)';
COMMENT ON COLUMN portfolio.profile.created_at IS 'Timestamp when profile was created';
COMMENT ON COLUMN portfolio.profile.updated_at IS 'Timestamp when profile was last updated';
