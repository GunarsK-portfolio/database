-- Create certifications table
CREATE TABLE portfolio.certifications (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    issuer VARCHAR(100) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE,
    credential_id VARCHAR(100) UNIQUE,
    credential_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on issue_date for sorting (most recent first)
CREATE INDEX idx_certifications_issue_date ON portfolio.certifications(issue_date DESC);

-- Create index on credential_id for lookups
CREATE INDEX idx_certifications_credential_id ON portfolio.certifications(credential_id);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_certifications_updated_at BEFORE UPDATE ON portfolio.certifications FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE portfolio.certifications IS 'Professional certifications and credentials';
COMMENT ON COLUMN portfolio.certifications.id IS 'Unique certification identifier';
COMMENT ON COLUMN portfolio.certifications.name IS 'Certification name (e.g., AWS Certified Solutions Architect)';
COMMENT ON COLUMN portfolio.certifications.issuer IS 'Issuing organization (e.g., Amazon Web Services)';
COMMENT ON COLUMN portfolio.certifications.issue_date IS 'Date when certification was issued';
COMMENT ON COLUMN portfolio.certifications.expiry_date IS 'Date when certification expires (NULL if no expiry)';
COMMENT ON COLUMN portfolio.certifications.credential_id IS 'Unique credential identifier from issuer';
COMMENT ON COLUMN portfolio.certifications.credential_url IS 'URL to verify certification';
COMMENT ON COLUMN portfolio.certifications.created_at IS 'Timestamp when record was created';
COMMENT ON COLUMN portfolio.certifications.updated_at IS 'Timestamp when record was last updated';
