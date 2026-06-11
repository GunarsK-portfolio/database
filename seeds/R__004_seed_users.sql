-- Seed users (repeatable; existing rows are not updated)
-- Admin user: full access for portfolio management
-- Password: admin123 (bcrypt hash)
INSERT INTO auth.users (username, email, password_hash)
VALUES (
    'admin',
    'admin@gunarsk.com',
    '$2b$10$XpkI4APkFljrOnbXYUa1X.bgYIEByPlC4woG8jxH08rKm/tB0/T5i'
)
ON CONFLICT DO NOTHING;

-- Demo user: limited access for portfolio demonstration (no messaging)
-- Password: demo123 (bcrypt hash)
INSERT INTO auth.users (username, email, password_hash)
VALUES (
    'demo',
    'demo@gunarsk.com',
    '$2a$10$6SJyoW1mqNE9rMaSSHbBGuxpIpTtzwFO6Xd/dtam8Xe4BemRu61Sm'
)
ON CONFLICT DO NOTHING;

-- Assign roles via user_roles junction table
INSERT INTO auth.user_roles (user_id, role_id)
SELECT u.id, r.id
FROM auth.users u, auth.roles r
WHERE u.username = 'admin' AND r.code = 'admin'
ON CONFLICT ON CONSTRAINT unique_user_role DO NOTHING;

INSERT INTO auth.user_roles (user_id, role_id)
SELECT u.id, r.id
FROM auth.users u, auth.roles r
WHERE u.username = 'demo' AND r.code = 'demo-user'
ON CONFLICT ON CONSTRAINT unique_user_role DO NOTHING;
