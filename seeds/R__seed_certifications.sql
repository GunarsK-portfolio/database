-- Seed certifications data

WITH certifications_data(cert_name, issuer_name, issue_date, expiry_date, credential_id, credential_url) AS (
    VALUES
    ('AWS Certified Solutions Architect - Associate', 'Amazon Web Services', DATE '2024-01-15', DATE '2027-01-15', 'AWS-SAA-12345678', 'https://aws.amazon.com/verification'),
    ('Certified Kubernetes Administrator (CKA)', 'Cloud Native Computing Foundation', DATE '2023-06-01', DATE '2026-06-01', 'CKA-2023-001234', 'https://training.linuxfoundation.org/certification/verify'),
    ('Professional Scrum Master I (PSM I)', 'Scrum.org', DATE '2023-03-10', NULL, 'PSM1-0123456', 'https://scrum.org/certificates'),
    ('HashiCorp Certified: Terraform Associate', 'HashiCorp', DATE '2022-11-20', DATE '2024-11-20', 'TERRAFORM-00123456', 'https://hashicorp.com/certification/verify'),
    ('Docker Certified Associate', 'Docker Inc.', DATE '2022-08-05', DATE '2025-08-05', 'DCA-123456789', 'https://credentials.docker.com'),
    ('GitHub Actions Certification', 'GitHub', DATE '2023-09-15', NULL, 'GHA-CERT-2023-456', 'https://github.com/certificates')
)
INSERT INTO portfolio.certifications (name, issuer, issue_date, expiry_date, credential_id, credential_url)
SELECT cd.cert_name, cd.issuer_name, cd.issue_date, cd.expiry_date, cd.credential_id, cd.credential_url
FROM certifications_data cd
ON CONFLICT (credential_id) DO UPDATE SET
    name = EXCLUDED.name,
    issuer = EXCLUDED.issuer,
    issue_date = EXCLUDED.issue_date,
    expiry_date = EXCLUDED.expiry_date,
    credential_url = EXCLUDED.credential_url;
