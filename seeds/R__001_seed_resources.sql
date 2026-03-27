-- Seed resources (repeatable - can be modified and re-run)
INSERT INTO auth.resources (code, name)
VALUES
('profile', 'Profile'),
('skills', 'Skills'),
('experience', 'Experience'),
('certifications', 'Certifications'),
('projects', 'Projects'),
('miniatures', 'Miniatures'),
('messages', 'Contact Messages'),
('recipients', 'Message Recipients'),
('files', 'Files'),
('users', 'Users'),
('classifiers', 'Classifiers'),
('heroes', 'Heroes'),
('campaigns', 'Campaigns')
ON CONFLICT (code) DO UPDATE SET name = excluded.name;
