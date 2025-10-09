-- Create certifications table
CREATE TABLE certifications (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    issuer VARCHAR(100) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE,
    credential_id VARCHAR(100),
    credential_url VARCHAR(255),
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on display_order for sorting
CREATE INDEX idx_certifications_display_order ON certifications(display_order);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_certifications_updated_at BEFORE UPDATE ON certifications
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
