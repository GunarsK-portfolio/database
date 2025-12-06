-- Seed users (repeatable - can be modified and re-run)
-- Admin user: created by V20251016140000 migration, just assign role
UPDATE auth.users
SET
    role_id = (
        SELECT id
        FROM auth.roles
        WHERE code = 'admin'
    )
WHERE username = 'admin' AND role_id IS NULL;

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
