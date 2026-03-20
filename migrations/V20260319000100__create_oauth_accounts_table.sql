CREATE TABLE auth.oauth_accounts (
    id BIGSERIAL PRIMARY KEY,
    provider VARCHAR(20) NOT NULL, -- noqa: RF04
    provider_user_id VARCHAR(255) NOT NULL,
    user_id BIGINT NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_oauth_provider_user UNIQUE (provider, provider_user_id)
);

CREATE INDEX idx_oauth_accounts_user_id ON auth.oauth_accounts (user_id);

COMMENT ON TABLE auth.oauth_accounts IS 'External OAuth provider identities linked to users';
COMMENT ON COLUMN auth.oauth_accounts.id IS 'Unique OAuth account identifier';
COMMENT ON COLUMN auth.oauth_accounts.provider IS 'OAuth provider name (e.g. google)';
COMMENT ON COLUMN auth.oauth_accounts.provider_user_id IS 'Unique user ID from the OAuth provider (Google sub claim)';
COMMENT ON COLUMN auth.oauth_accounts.user_id IS 'Reference to the linked auth.users record';
COMMENT ON COLUMN auth.oauth_accounts.email IS 'Email address from the OAuth provider at link time';
COMMENT ON COLUMN auth.oauth_accounts.created_at IS 'Timestamp when the OAuth account was linked';

ALTER TABLE auth.users
ALTER COLUMN password_hash DROP NOT NULL;

COMMENT ON COLUMN auth.users.password_hash IS 'Bcrypt hash, NULL for OAuth-only users';

GRANT SELECT, INSERT, UPDATE, DELETE ON auth.oauth_accounts TO portfolio_admin;
