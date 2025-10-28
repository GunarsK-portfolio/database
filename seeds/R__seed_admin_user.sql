-- Seed admin user
-- Password: admin123 (bcrypt hash with cost 10)
-- Note: This is for development only. Change password in production!

WITH admin_user_data(username, email, password_hash) AS (
    VALUES
    ('admin', 'admin@portfolio.local', '$2b$10$XpkI4APkFljrOnbXYUa1X.bgYIEByPlC4woG8jxH08rKm/tB0/T5i')
)
INSERT INTO auth.users (username, email, password_hash)
SELECT ad.username, ad.email, ad.password_hash
FROM admin_user_data ad
ON CONFLICT (username) DO UPDATE SET
    email = EXCLUDED.email,
    password_hash = EXCLUDED.password_hash;
