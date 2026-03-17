-- Harden verification_tokens: add type discriminator, token hashing,
-- expiry support, and used_at audit column.
--
-- Token hashing: raw tokens exist only in email links. DB stores SHA-256
-- hashes so a database compromise doesn't expose usable tokens.
--
-- used_at: tokens are marked as consumed rather than deleted, providing
-- an audit trail of when tokens were used.

-- Add new columns
ALTER TABLE auth.verification_tokens
ADD COLUMN type VARCHAR(30) NOT NULL DEFAULT 'email_verification';

ALTER TABLE auth.verification_tokens
ADD COLUMN expires_at TIMESTAMPTZ;

ALTER TABLE auth.verification_tokens
ADD COLUMN used_at TIMESTAMPTZ;

-- Hash existing raw tokens in place.
-- token::bytea converts the hex string to its UTF-8 byte representation
-- (same as Go's []byte(token)). The result is hex-encoded to match
-- Go's hex.EncodeToString(sha256.Sum256(...)).
UPDATE auth.verification_tokens
SET token = encode(sha256(token::BYTEA), 'hex');

-- Constraints
ALTER TABLE auth.verification_tokens
ADD CONSTRAINT chk_verification_tokens_type
CHECK (type IN ('email_verification', 'password_reset'));

-- Backfill expires_at for existing tokens so they don't remain valid forever
UPDATE auth.verification_tokens
SET expires_at = created_at + INTERVAL '24 hours'
WHERE expires_at IS NULL;

-- Indexes: composite (user_id, type) replaces the standalone user_id index
DROP INDEX IF EXISTS auth.idx_verification_tokens_user_id;

CREATE INDEX idx_verification_tokens_user_id_type
ON auth.verification_tokens (user_id, type);

CREATE INDEX idx_verification_tokens_used_at
ON auth.verification_tokens (used_at)
WHERE used_at IS NULL;

-- Comments
COMMENT ON COLUMN auth.verification_tokens.type IS 'Token purpose: email_verification or password_reset';
COMMENT ON COLUMN auth.verification_tokens.token IS 'SHA-256 hash of the raw token (hex-encoded, 64 chars)';
COMMENT ON COLUMN auth.verification_tokens.expires_at IS 'Expiry timestamp (NULL = never expires, used for email verification tokens)';
COMMENT ON COLUMN auth.verification_tokens.used_at IS 'Timestamp when token was consumed (NULL = not yet used)';
