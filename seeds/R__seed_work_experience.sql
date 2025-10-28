-- Seed work experience data

WITH work_experience_data(company_name, position_title, job_description, start_date, end_date, is_current) AS (
    VALUES
    ('Tech Innovators Inc.', 'Senior Full Stack Developer',
     'Led development of cloud-native microservices architecture using Go and Vue.js. Implemented CI/CD pipelines reducing deployment time by 60%. Mentored junior developers and conducted code reviews.',
     DATE '2022-03-01', NULL, true),

    ('Digital Solutions Corp.', 'Full Stack Developer',
     'Built and maintained RESTful APIs using Node.js and Express. Developed responsive web applications with Vue.js and React. Collaborated with cross-functional teams in Agile environment.',
     DATE '2020-01-15', DATE '2022-02-28', false),

    ('StartUp Ventures', 'Junior Developer',
     'Assisted in development of e-commerce platform using modern web technologies. Fixed bugs, wrote unit tests, and participated in sprint planning. Gained hands-on experience with Git workflows and code reviews.',
     DATE '2018-06-01', DATE '2019-12-31', false),

    ('WebDev Agency', 'Frontend Developer Intern',
     'Created responsive landing pages and marketing websites using HTML, CSS, and JavaScript. Optimized website performance and SEO. Collaborated with designers to implement pixel-perfect UI components.',
     DATE '2017-09-01', DATE '2018-05-31', false)
)
INSERT INTO portfolio.work_experience (company, position, description, start_date, end_date, is_current)
SELECT wd.company_name, wd.position_title, wd.job_description, wd.start_date, wd.end_date, wd.is_current
FROM work_experience_data wd
WHERE NOT EXISTS (
    SELECT 1 FROM portfolio.work_experience we
    WHERE we.company = wd.company_name
    AND we.position = wd.position_title
    AND we.start_date = wd.start_date
);
