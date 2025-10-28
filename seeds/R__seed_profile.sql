-- Seed profile data
-- Note: This table should have exactly 1 row (singleton)

INSERT INTO portfolio.profile (full_name, title, bio, email, phone, location)
SELECT
    'John Doe',
    'Full Stack Developer & Miniature Painter',
    'Passionate software engineer with expertise in modern web technologies and a creative hobby of miniature painting. I build scalable applications and bring tiny worlds to life.',
    'john.doe@example.com',
    '+1 (555) 123-4567',
    'San Francisco, CA, USA'
WHERE NOT EXISTS (
    SELECT 1 FROM portfolio.profile LIMIT 1
);
