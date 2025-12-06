-- Seed role scopes (repeatable - can be modified and re-run)
-- Clear existing scopes for roles we're seeding
DELETE FROM auth.role_scopes
WHERE role_id IN (
    SELECT id
    FROM auth.roles
    WHERE code IN ('admin', 'read-only', 'demo-user')
);

-- Admin permissions: all resources = delete (full access)
INSERT INTO auth.role_scopes (role_id, resource_id, permission_level)
SELECT
    r.id AS role_id,
    res.id AS resource_id,
    'delete' AS permission_level
FROM auth.roles AS r
CROSS JOIN auth.resources AS res
WHERE r.code = 'admin';

-- Read-only permissions: all resources = read except users = none
INSERT INTO auth.role_scopes (role_id, resource_id, permission_level)
SELECT
    r.id AS role_id,
    res.id AS resource_id,
    CASE WHEN res.code = 'users' THEN 'none' ELSE 'read' END AS permission_level
FROM auth.roles AS r
CROSS JOIN auth.resources AS res
WHERE r.code = 'read-only';

-- Demo-user permissions: read portfolio content, no access to users/messages/recipients
INSERT INTO auth.role_scopes (role_id, resource_id, permission_level)
SELECT
    r.id AS role_id,
    res.id AS resource_id,
    CASE
        WHEN res.code IN ('users', 'messages', 'recipients') THEN 'none'
        ELSE 'read'
    END AS permission_level
FROM auth.roles AS r
CROSS JOIN auth.resources AS res
WHERE r.code = 'demo-user';
