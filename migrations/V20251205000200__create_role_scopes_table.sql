-- Role scopes table: maps roles to resources with permission levels
CREATE TABLE auth.role_scopes (
    role_id INT REFERENCES auth.roles (id) ON DELETE CASCADE,
    resource_id INT REFERENCES auth.resources (id) ON DELETE CASCADE,
    permission_level VARCHAR(10) NOT NULL DEFAULT 'none',
    PRIMARY KEY (role_id, resource_id),
    CONSTRAINT valid_level CHECK (permission_level IN ('none', 'read', 'edit', 'delete'))
);

CREATE INDEX idx_role_scopes_role_id ON auth.role_scopes (role_id);
CREATE INDEX idx_role_scopes_resource_id ON auth.role_scopes (resource_id);
