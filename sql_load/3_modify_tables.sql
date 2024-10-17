/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM '[Insert File Path]/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM '[Insert File Path]/skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM '[Insert File Path]/job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM '[Insert File Path]/skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- NOTE: This has been updated from the video to fix issues with encoding

COPY company_dim
FROM 'C:\Users\User\Desktop\SQL\all_folders\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

LOAD DATA INFILE 'C:/Users/User/Desktop/SQL/all_folders/csv_files/company_dim.csv'
INTO TABLE company_dim
FIELDS TERMINATED BY ','       -- The delimiter is a comma
ENCLOSED BY '"'                -- Optional, if your fields are enclosed by quotes
LINES TERMINATED BY '\n'        -- Line termination
IGNORE 1 LINES                 -- Skips the header row if your CSV has headers
(company_id, name, link, link_google, thumbnail); -- List of columns matching CSV order


COPY skills_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

LOAD DATA INFILE 'C:/Users/User/Desktop/SQL/all_folders/csv_files/skills_dim.csv'
INTO TABLE skills_dim
FIELDS TERMINATED BY ','          -- The delimiter is a comma
ENCLOSED BY '"'                   -- Optional, if your fields are enclosed by quotes
LINES TERMINATED BY '\n'          -- Line termination
IGNORE 1 LINES                    -- Skips the header row if your CSV has headers
(skill_id, skills);                -- List of columns matching CSV order


COPY job_postings_fact
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

LOAD DATA INFILE 'job_postings_fact.csv'
INTO TABLE job_postings_fact
FIELDS TERMINATED BY ','          -- The delimiter is a comma
ENCLOSED BY '"'                   -- Optional, if your fields are enclosed by quotes
LINES TERMINATED BY '\n'          -- Line termination
IGNORE 1 LINES                    -- Skips the header row if your CSV has headers
(job_id, company_id, job_title_short, job_title, job_location, job_via, job_schedule_type, job_work_from_home, search_location, job_posted_date, job_no_degree_mention, job_health_insurance, job_country, salary_rate, salary_year_avg, salary_hour_avg); -- List of columns matching CSV order

COPY skills_job_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
