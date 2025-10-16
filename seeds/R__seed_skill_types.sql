-- Seed skill type classifiers
INSERT INTO portfolio.cl_skill_types (name, description, display_order)
VALUES
    ('Frontend', 'Frontend development technologies and frameworks', 1),
    ('Backend', 'Backend development languages and frameworks', 2),
    ('Database', 'Database systems and query languages', 3),
    ('DevOps & Tools', 'CI/CD, containerization, cloud platforms, and development tools', 4),
    ('Languages', 'Programming and scripting languages', 5),
    ('Other', 'Other technical skills and competencies', 6)
ON CONFLICT (name) DO UPDATE SET
    description = EXCLUDED.description,
    display_order = EXCLUDED.display_order;
