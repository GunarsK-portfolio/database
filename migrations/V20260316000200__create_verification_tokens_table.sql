-- Verification tokens for email verification flow
-- Tokens are generated on registration and deleted on use or email change
CREATE TABLE auth.verification_tokens (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
    email VARCHAR(100) NOT NULL,
    token VARCHAR(64) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_verification_tokens_user_id
ON auth.verification_tokens (user_id);

COMMENT ON TABLE auth.verification_tokens IS 'Email verification tokens for user email confirmation';
COMMENT ON COLUMN auth.verification_tokens.user_id IS 'Reference to the user requesting verification';
COMMENT ON COLUMN auth.verification_tokens.email IS 'Email address being verified (may differ from current user email if changed)';
COMMENT ON COLUMN auth.verification_tokens.token IS 'Unique verification token (64 hex chars)';
COMMENT ON COLUMN auth.verification_tokens.created_at IS 'Timestamp when token was generated';
