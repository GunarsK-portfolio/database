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

-- rpg-admin: classifiers=delete, heroes=delete, campaigns=delete, files=delete
DELETE FROM auth.role_scopes
WHERE role_id IN (
    SELECT id
    FROM auth.roles
    WHERE code IN ('rpg-admin', 'rpg-gm', 'rpg-player')
);

INSERT INTO auth.role_scopes (role_id, resource_id, permission_level)
SELECT
    r.id AS role_id,
    res.id AS resource_id,
    'delete' AS permission_level
FROM auth.roles AS r
CROSS JOIN auth.resources AS res
WHERE
    r.code = 'rpg-admin'
    AND res.code IN ('classifiers', 'heroes', 'campaigns', 'files');

-- rpg-gm: classifiers=delete, heroes=delete, campaigns=delete, files=delete
-- Homebrew ownership is enforced at the DB layer (user_id check), so 'delete'
-- on classifiers only grants access to the user's own homebrew rows.
INSERT INTO auth.role_scopes (role_id, resource_id, permission_level)
SELECT
    r.id AS role_id,
    res.id AS resource_id,
    'delete' AS permission_level
FROM auth.roles AS r
CROSS JOIN auth.resources AS res
WHERE
    r.code = 'rpg-gm'
    AND res.code IN ('classifiers', 'heroes', 'campaigns', 'files');

-- rpg-player: classifiers=delete, heroes=delete, campaigns=delete, files=delete
INSERT INTO auth.role_scopes (role_id, resource_id, permission_level)
SELECT
    r.id AS role_id,
    res.id AS resource_id,
    'delete' AS permission_level
FROM auth.roles AS r
CROSS JOIN auth.resources AS res
WHERE
    r.code = 'rpg-player'
    AND res.code IN ('classifiers', 'heroes', 'campaigns', 'files');
