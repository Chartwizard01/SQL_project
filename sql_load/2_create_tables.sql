-- Create company_dim table with primary key
CREATE TABLE sql_course.company_dim (
    company_id INT PRIMARY KEY,
    name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);

-- Create skills_dim table with primary key
CREATE TABLE sql_course.skills_dim
(
    skill_id INT PRIMARY KEY,
    skills TEXT,
    type TEXT
);

-- Create job_postings_fact table with primary key
CREATE TABLE sql_course.job_postings_fact (
    job_id INT PRIMARY KEY,
    company_id INT,
    job_title_short VARCHAR(255),
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES sql_course.company_dim(company_id)
);


-- Create skills_job_dim table with a composite primary key and foreign keys
CREATE TABLE sql_course.skills_job_dim
(
    job_id INT,
    skill_id INT,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES sql_course.job_postings_fact (job_id),
    FOREIGN KEY (skill_id) REFERENCES sql_course.skills_dim (skill_id)
);

-- Set ownership of the tables to the postgres user
GRANT ALL PRIVILEGES ON sql_course.* TO 'root'@'localhost';


-- Create indexes on foreign key columns for better performance
CREATE INDEX idx_company_id ON sql_course.job_postings_fact (company_id);
CREATE INDEX idx_skill_id ON sql_course.skills_job_dim (skill_id);
CREATE INDEX idx_job_id ON sql_course.skills_job_dim (job_id);

SELECT CURRENT_USER();
