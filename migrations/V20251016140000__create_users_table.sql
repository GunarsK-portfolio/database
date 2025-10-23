-- Create users table for authentication
CREATE TABLE auth.users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on username and email for faster lookups
CREATE INDEX idx_users_username ON auth.users (username);
CREATE INDEX idx_users_email ON auth.users (email);

-- Create function to update updated_at timestamp (in public schema for reuse)
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Add table and column comments
COMMENT ON TABLE auth.users IS 'Authentication users for portfolio admin access';
COMMENT ON COLUMN auth.users.id IS 'Unique user identifier';
COMMENT ON COLUMN auth.users.username IS 'Unique username for login';
COMMENT ON COLUMN auth.users.email IS 'Unique email address';
COMMENT ON COLUMN auth.users.password_hash IS 'Bcrypt hashed password';
COMMENT ON COLUMN auth.users.created_at IS 'Timestamp when user was created';
COMMENT ON COLUMN auth.users.updated_at IS 'Timestamp when user was last updated';
