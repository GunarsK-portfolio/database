-- Seed sample profile data
INSERT INTO portfolio.profile (full_name, title, bio, email, phone, location)
VALUES (
    'Your Name',
    'Software Engineer',
    'Passionate about software development and miniature painting.',
    'your.email@example.com',
    '+1234567890',
    'Your City, Country'
)
ON CONFLICT DO NOTHING;

-- Seed sample work experience
INSERT INTO portfolio.work_experience (company, position, description, start_date, end_date, is_current)
VALUES
    ('Example Company', 'Senior Developer', 'Led development of key features...', '2020-01-01', NULL, TRUE),
    ('Previous Company', 'Developer', 'Worked on various projects...', '2018-01-01', '2019-12-31', FALSE)
ON CONFLICT DO NOTHING;

-- Seed sample certifications
INSERT INTO portfolio.certifications (name, issuer, issue_date, credential_id)
VALUES
    ('AWS Certified Solutions Architect', 'Amazon Web Services', '2023-01-15', 'AWS-12345'),
    ('Certified Kubernetes Administrator', 'CNCF', '2022-06-01', 'CKA-67890')
ON CONFLICT DO NOTHING;

-- Seed sample miniature projects
INSERT INTO miniatures.miniature_projects (title, description, completed_date, display_order)
VALUES
    ('Space Marine Squad', 'Painted a full squad of Space Marines with custom chapter colors', '2024-01-15', 1),
    ('Fantasy Terrain Set', 'Scratch-built and painted medieval terrain pieces', '2023-12-01', 2)
ON CONFLICT DO NOTHING;
