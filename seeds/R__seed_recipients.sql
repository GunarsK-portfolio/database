-- Seed default email recipient for contact form notifications
-- Note: Update email address for production deployment

WITH recipient_data(email, name, is_active) AS (
    VALUES
    ('gunarskunakovs@gmail.com', 'Gunars Kunakovs', true)
)
INSERT INTO messaging.recipients (email, name, is_active)
SELECT rd.email, rd.name, rd.is_active
FROM recipient_data rd
ON CONFLICT (email) DO UPDATE SET
    name = EXCLUDED.name,
    is_active = EXCLUDED.is_active;
