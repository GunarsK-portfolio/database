-- Seed skills based on actual technologies used in the portfolio project

WITH skill_types AS (
    SELECT id, name FROM portfolio.cl_skill_types
),
skills_data(skill_name, type_name, is_visible, display_order) AS (
    VALUES
    -- Frontend Skills
    ('Vue.js', 'Frontend', true, 10),
    ('Vite', 'Frontend', true, 20),
    ('Vue Router', 'Frontend', true, 30),
    ('Pinia', 'Frontend', true, 40),
    ('Naive UI', 'Frontend', true, 50),
    ('Axios', 'Frontend', true, 60),
    ('ESLint', 'Frontend', true, 70),
    ('Prettier', 'Frontend', true, 80),
    ('Nginx', 'Frontend', true, 90),

    -- Backend Skills
    ('Go', 'Backend', true, 10),
    ('Gin', 'Backend', true, 20),
    ('GORM', 'Backend', true, 30),
    ('JWT Authentication', 'Backend', true, 40),
    ('RESTful APIs', 'Backend', true, 50),
    ('Swagger/OpenAPI', 'Backend', true, 60),

    -- Database Skills
    ('PostgreSQL', 'Database', true, 10),
    ('Redis', 'Database', true, 20),
    ('Flyway', 'Database', true, 30),
    ('MinIO (S3)', 'Database', true, 40),

    -- DevOps & Tools Skills
    ('Docker', 'DevOps & Tools', true, 10),
    ('Docker Compose', 'DevOps & Tools', true, 20),
    ('Traefik', 'DevOps & Tools', true, 30),
    ('Prometheus', 'DevOps & Tools', true, 40),
    ('Grafana', 'DevOps & Tools', true, 50),
    ('GitHub Actions', 'DevOps & Tools', true, 60),
    ('Git', 'DevOps & Tools', true, 70),
    ('VS Code', 'DevOps & Tools', true, 80),
    ('Linux/Alpine', 'DevOps & Tools', true, 90),

    -- Programming Languages
    ('JavaScript/TypeScript', 'Languages', true, 10),
    ('Go (Golang)', 'Languages', true, 20),
    ('SQL', 'Languages', true, 30),
    ('YAML', 'Languages', true, 40),

    -- Other Skills
    ('Microservices Architecture', 'Other', true, 10),
    ('API Design', 'Other', true, 20),
    ('Security Best Practices', 'Other', true, 30),
    ('Code Quality & Testing', 'Other', true, 40)
)
INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT
    sd.skill_name,
    st.id,
    sd.is_visible,
    sd.display_order
FROM skills_data sd
JOIN skill_types st ON sd.type_name = st.name
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;
