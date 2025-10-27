-- Seed skills based on actual technologies used in the portfolio project
-- This is a repeatable migration (R__) that can be run multiple times
-- Uses ON CONFLICT to prevent duplicates

-- ============================================================================
-- FRONTEND SKILLS
-- ============================================================================

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Vue.js', id, true, 10 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Vite', id, true, 20 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Vue Router', id, true, 30 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Pinia', id, true, 40 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Naive UI', id, true, 50 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Axios', id, true, 60 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'ESLint', id, true, 70 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Prettier', id, true, 80 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Nginx', id, true, 90 FROM portfolio.cl_skill_types WHERE name = 'Frontend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

-- ============================================================================
-- BACKEND SKILLS
-- ============================================================================

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Go', id, true, 10 FROM portfolio.cl_skill_types WHERE name = 'Backend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Gin', id, true, 20 FROM portfolio.cl_skill_types WHERE name = 'Backend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'GORM', id, true, 30 FROM portfolio.cl_skill_types WHERE name = 'Backend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'JWT Authentication', id, true, 40 FROM portfolio.cl_skill_types WHERE name = 'Backend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'RESTful APIs', id, true, 50 FROM portfolio.cl_skill_types WHERE name = 'Backend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Swagger/OpenAPI', id, true, 60 FROM portfolio.cl_skill_types WHERE name = 'Backend'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

-- ============================================================================
-- DATABASE SKILLS
-- ============================================================================

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'PostgreSQL', id, true, 10 FROM portfolio.cl_skill_types WHERE name = 'Database'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Redis', id, true, 20 FROM portfolio.cl_skill_types WHERE name = 'Database'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Flyway', id, true, 30 FROM portfolio.cl_skill_types WHERE name = 'Database'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'MinIO (S3)', id, true, 40 FROM portfolio.cl_skill_types WHERE name = 'Database'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

-- ============================================================================
-- DEVOPS & TOOLS SKILLS
-- ============================================================================

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Docker', id, true, 10 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Docker Compose', id, true, 20 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Traefik', id, true, 30 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Prometheus', id, true, 40 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Grafana', id, true, 50 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'GitHub Actions', id, true, 60 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Git', id, true, 70 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'VS Code', id, true, 80 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Linux/Alpine', id, true, 90 FROM portfolio.cl_skill_types WHERE name = 'DevOps & Tools'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

-- ============================================================================
-- PROGRAMMING LANGUAGES
-- ============================================================================

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'JavaScript/TypeScript', id, true, 10 FROM portfolio.cl_skill_types WHERE name = 'Languages'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Go (Golang)', id, true, 20 FROM portfolio.cl_skill_types WHERE name = 'Languages'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'SQL', id, true, 30 FROM portfolio.cl_skill_types WHERE name = 'Languages'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'YAML', id, true, 40 FROM portfolio.cl_skill_types WHERE name = 'Languages'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

-- ============================================================================
-- OTHER SKILLS
-- ============================================================================

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Microservices Architecture', id, true, 10 FROM portfolio.cl_skill_types WHERE name = 'Other'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'API Design', id, true, 20 FROM portfolio.cl_skill_types WHERE name = 'Other'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Security Best Practices', id, true, 30 FROM portfolio.cl_skill_types WHERE name = 'Other'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;

INSERT INTO portfolio.skills (skill, skill_type_id, is_visible, display_order)
SELECT 'Code Quality & Testing', id, true, 40 FROM portfolio.cl_skill_types WHERE name = 'Other'
ON CONFLICT (skill) DO UPDATE SET
    skill_type_id = EXCLUDED.skill_type_id,
    is_visible = EXCLUDED.is_visible,
    display_order = EXCLUDED.display_order;
