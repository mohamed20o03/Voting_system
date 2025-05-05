USE voting_system;

-- Education tables
CREATE TABLE EducationLevels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    level_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

select 'education ok';