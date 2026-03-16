-- Service account for auth-service -> messaging-api S2S JWT auth
-- This user never authenticates via login; password is an unusable random hash
INSERT INTO auth.users (username, email, password_hash)
VALUES (
    'svc-auth',
    'svc-auth@internal',
    '$2a$12$LJ3m4ys3Lk0THnbieSTUDOYx6Bx2OsfRqGvKnFw9SeAjkwb3AIWXK'
);
