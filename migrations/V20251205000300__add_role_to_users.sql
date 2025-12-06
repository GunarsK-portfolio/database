-- Add role reference to users table
ALTER TABLE auth.users ADD COLUMN role_id INT REFERENCES auth.roles (id);

CREATE INDEX idx_users_role_id ON auth.users (role_id);
