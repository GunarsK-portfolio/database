-- Seed roles (repeatable - can be modified and re-run)
INSERT INTO auth.roles (code, name)
VALUES
('admin', 'Administrator'),
('read-only', 'Read Only')
ON CONFLICT (code) DO UPDATE SET name = excluded.name;
