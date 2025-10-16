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
