-- Seed portfolio projects data

WITH projects_data(
    project_title, category_name, short_desc, long_desc, github_url, live_url,
    start_date, end_date, is_ongoing, team_size, role_name, featured, display_order,
    features_json, challenges_json, learnings_json
) AS (
    VALUES
    (
        'Portfolio Management System',
        'Web Application',
        'Full-stack portfolio management system with admin dashboard and public website',
        'A comprehensive portfolio management system built with microservices architecture. Features separate admin and public interfaces, cloud-native deployment, and modern CI/CD practices.',
        'https://github.com/yourusername/portfolio',
        'https://portfolio.example.com',
        DATE '2024-10-01', NULL, true, 1, 'Full Stack Developer', true, 1,
        '["Admin dashboard with CRUD operations", "Public portfolio website", "Image cropping and upload", "Skills and certifications management", "Docker containerization"]'::jsonb,
        '["Implementing efficient image processing", "Setting up microservices communication", "Database migration management with Flyway"]'::jsonb,
        '["Advanced Vue.js composition API patterns", "Go backend architecture", "Docker multi-stage builds", "PostgreSQL performance optimization"]'::jsonb
    ),
    (
        'E-Commerce Platform',
        'Web Application',
        'Scalable e-commerce platform with payment integration and inventory management',
        'Built a robust e-commerce platform handling thousands of products and orders. Integrated multiple payment gateways and implemented real-time inventory tracking.',
        'https://github.com/yourusername/ecommerce',
        'https://shop.example.com',
        DATE '2023-05-01', DATE '2024-03-31', false, 4, 'Backend Lead', true, 2,
        '["Multi-vendor support", "Real-time inventory tracking", "Payment gateway integration", "Advanced search with Elasticsearch", "Order management system"]'::jsonb,
        '["Handling high concurrent transactions", "Implementing distributed caching", "Managing complex product variations"]'::jsonb,
        '["Microservices patterns", "Event-driven architecture", "Database sharding strategies"]'::jsonb
    ),
    (
        'Task Management CLI Tool',
        'CLI Tool',
        'Command-line task management tool with Git-like interface',
        'A powerful CLI tool for managing tasks and projects with an intuitive Git-like command structure. Supports task dependencies, time tracking, and custom workflows.',
        'https://github.com/yourusername/taskcli',
        NULL,
        DATE '2023-01-10', DATE '2023-04-20', false, 1, 'Solo Developer', false, 3,
        '["Git-like command interface", "Task dependencies", "Time tracking", "Custom workflows", "Export to multiple formats"]'::jsonb,
        '["Designing intuitive CLI UX", "Handling complex task relationships", "Cross-platform compatibility"]'::jsonb,
        '["CLI design patterns", "Go Cobra framework", "Terminal UI best practices"]'::jsonb
    ),
    (
        'API Gateway Service',
        'Microservice',
        'High-performance API gateway with rate limiting and authentication',
        'Custom API gateway service built with Go handling authentication, rate limiting, and request routing for microservices architecture.',
        'https://github.com/yourusername/api-gateway',
        NULL,
        DATE '2022-08-15', DATE '2022-12-10', false, 2, 'Backend Developer', false, 4,
        '["JWT authentication", "Rate limiting", "Request routing", "Health checks", "Metrics collection"]'::jsonb,
        '["High-performance request handling", "Implementing circuit breakers", "Managing service discovery"]'::jsonb,
        '["Go concurrency patterns", "Distributed systems design", "API gateway patterns"]'::jsonb
    )
)
INSERT INTO portfolio.portfolio_projects (
    title, category, description, long_description, github_url, live_url,
    start_date, end_date, is_ongoing, team_size, role, featured, display_order,
    features, challenges, learnings
)
SELECT
    pd.project_title, pd.category_name, pd.short_desc, pd.long_desc, pd.github_url, pd.live_url,
    pd.start_date, pd.end_date, pd.is_ongoing, pd.team_size, pd.role_name, pd.featured, pd.display_order,
    pd.features_json, pd.challenges_json, pd.learnings_json
FROM projects_data pd
ON CONFLICT (title) DO UPDATE SET
    category = EXCLUDED.category,
    description = EXCLUDED.description,
    long_description = EXCLUDED.long_description,
    github_url = EXCLUDED.github_url,
    live_url = EXCLUDED.live_url,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    is_ongoing = EXCLUDED.is_ongoing,
    team_size = EXCLUDED.team_size,
    role = EXCLUDED.role,
    featured = EXCLUDED.featured,
    display_order = EXCLUDED.display_order,
    features = EXCLUDED.features,
    challenges = EXCLUDED.challenges,
    learnings = EXCLUDED.learnings;
