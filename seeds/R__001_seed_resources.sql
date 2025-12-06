-- Seed resources (repeatable - can be modified and re-run)
INSERT INTO auth.resources (code, name)
VALUES
('profile', 'Profile'),
('skills', 'Skills'),
('experience', 'Experience'),
('certifications', 'Certifications'),
('projects', 'Projects'),
('miniatures', 'Miniatures'),
('messaging', 'Messaging'),
('files', 'Files'),
('users', 'Users')
ON CONFLICT (code) DO UPDATE SET name = excluded.name;
