-- Seed skill type classifiers

WITH skill_types_data(type_name, type_description, display_order) AS (
    VALUES
    ('Frontend', 'Frontend development technologies and frameworks', 1),
    ('Backend', 'Backend development languages and frameworks', 2),
    ('Database', 'Database systems and query languages', 3),
    ('DevOps & Tools', 'CI/CD, containerization, cloud platforms, and development tools', 4),
    ('Languages', 'Programming and scripting languages', 5),
    ('Other', 'Other technical skills and competencies', 6)
)
INSERT INTO portfolio.cl_skill_types (name, description, display_order)
SELECT std.type_name, std.type_description, std.display_order
FROM skill_types_data std
ON CONFLICT (name) DO UPDATE SET
    description = EXCLUDED.description,
    display_order = EXCLUDED.display_order;
