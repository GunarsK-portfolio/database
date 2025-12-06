-- Seed users (repeatable - can be modified and re-run)
-- Admin user: full access for portfolio management
-- Password: admin123 (bcrypt hash)
INSERT INTO auth.users (username, email, password_hash, role_id)
VALUES (
    'admin',
    'admin@gunarsk.com',
    '$2b$10$XpkI4APkFljrOnbXYUa1X.bgYIEByPlC4woG8jxH08rKm/tB0/T5i',
    (
        SELECT id
        FROM auth.roles
        WHERE code = 'admin'
    )
)
ON CONFLICT (username) DO UPDATE SET
    email = excluded.email,
    role_id = excluded.role_id;

-- Demo user: read-only access for portfolio demonstration
-- Password: demo123 (bcrypt hash)
INSERT INTO auth.users (username, email, password_hash, role_id)
VALUES (
    'demo',
    'demo@gunarsk.com',
    '$2a$10$6SJyoW1mqNE9rMaSSHbBGuxpIpTtzwFO6Xd/dtam8Xe4BemRu61Sm',
    (
        SELECT id
        FROM auth.roles
        WHERE code = 'read-only'
    )
)
ON CONFLICT (username) DO UPDATE SET
    email = excluded.email,
    role_id = excluded.role_id;
