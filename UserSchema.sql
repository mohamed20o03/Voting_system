USE voting_system;

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('male', 'female') NOT NULL,
    birth_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    current_address VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    account_verified BOOLEAN DEFAULT FALSE,
    profile_image VARCHAR(255)
);

-- user -> NID    NID -> nationality
CREATE TABLE Nationalities (
    national_id VARCHAR(20) PRIMARY KEY,
    user_id INT NOT NULL,
    nationality_address_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (nationality_address_id) REFERENCES NationalityAddresses(id) ON DELETE CASCADE
);



CREATE TABLE UserEducation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    education_level_id INT NOT NULL,
    major VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BOOLEAN DEFAULT FALSE,
    gpa DECIMAL(3,2),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (education_level_id) REFERENCES EducationLevels(id) ON DELETE CASCADE,
    CHECK (end_date IS NULL OR end_date >= start_date)
);

CREATE TABLE EnrolledIN (
    user_id INT NOT NULL,
    job_id INT NOT NULL,
    organization_id INT NOT NULL,
    seniority_level ENUM('Entry Level', 'Junior', 'Mid Level', 'Senior', 'Lead', 'Manager', 'Director', 'Executive') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (user_id, job_id, organization_id, start_date),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (job_id) REFERENCES Jobs(id) ON DELETE CASCADE,
    FOREIGN KEY (organization_id) REFERENCES Organizations(id) ON DELETE CASCADE,
    CONSTRAINT check_work_dates CHECK (end_date IS NULL OR end_date >= start_date)
);


select '4 user ok';