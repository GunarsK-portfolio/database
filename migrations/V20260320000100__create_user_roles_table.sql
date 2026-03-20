-- Create user_roles junction table for multi-role support
CREATE TABLE auth.user_roles (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
    role_id INT NOT NULL REFERENCES auth.roles (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_user_role UNIQUE (user_id, role_id)
);

CREATE INDEX idx_user_roles_role_id ON auth.user_roles (role_id);

COMMENT ON TABLE auth.user_roles IS 'Junction table mapping users to their assigned roles';
COMMENT ON COLUMN auth.user_roles.id IS 'Unique user-role assignment identifier';
COMMENT ON COLUMN auth.user_roles.user_id IS 'Reference to auth.users';
COMMENT ON COLUMN auth.user_roles.role_id IS 'Reference to auth.roles';
COMMENT ON COLUMN auth.user_roles.created_at IS 'Timestamp when the role was assigned';

-- Migrate existing role assignments
INSERT INTO auth.user_roles (user_id, role_id)
SELECT
    id,
    role_id
FROM auth.users
WHERE role_id IS NOT NULL;

-- Drop the old single-role column
ALTER TABLE auth.users DROP COLUMN role_id;

GRANT SELECT, INSERT, UPDATE, DELETE ON auth.user_roles TO portfolio_admin;
