-- Seed admin user
-- Password: admin123 (bcrypt hash with cost 10)
-- Note: This is for development only. Change password in production!

INSERT INTO users (username, email, password_hash)
VALUES ('admin', 'admin@portfolio.local', '$2b$10$XpkI4APkFljrOnbXYUa1X.bgYIEByPlC4woG8jxH08rKm/tB0/T5i')
ON CONFLICT (username) DO NOTHING;
