USE voting_system;

-- Election system tables
CREATE TABLE ElectionTypes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name ENUM('ONE_CHOICE', 'MULTI_CHOICE', 'REFERENDUM') NOT NULL,
    vote_count_method ENUM('ELECTORAL_COLLEGE', 'POPULAR_VOTE') NOT NULL,
    max_choices INT DEFAULT 1 NOT NULL,
    description TEXT,
    CHECK (
        (type_name = 'MULTI_CHOICE' AND max_choices > 1) OR
        (type_name != 'MULTI_CHOICE' AND max_choices = 1)
    ),
    CHECK (
        (vote_count_method = 'ELECTORAL_COLLEGE' AND max_choices = 1) OR
        (vote_count_method = 'POPULAR_VOTE')
    )
);

CREATE TABLE Elections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    election_name VARCHAR(100) NOT NULL,
    type_id INT NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    description TEXT,
    status ENUM('SCHEDULED', 'ACTIVE', 'COMPLETED', 'CANCELLED') DEFAULT 'SCHEDULED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    total_voters INT DEFAULT 0,   
    FOREIGN KEY (type_id) REFERENCES ElectionTypes(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES Users(id) ON DELETE SET NULL,
    CHECK (end_date > start_date)
);

CREATE TABLE ElectionGroups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    election_id INT NOT NULL,
    group_name VARCHAR(100) NOT NULL,
    score INT DEFAULT 1,
    description TEXT,
    FOREIGN KEY (election_id) REFERENCES Elections(id) ON DELETE CASCADE,
    UNIQUE KEY (election_id, group_name)
);

CREATE TABLE ElectionEligibility (
    id INT AUTO_INCREMENT PRIMARY KEY,
    election_id INT NOT NULL,
    attribute VARCHAR(100) NOT NULL COMMENT 'Field/attribute to check (age, nationality, etc.)',
    condition_type ENUM('EQUALS', 'NOT_EQUALS', 'GREATER_THAN', 'LESS_THAN', 'IN', 'NOT_IN') NOT NULL,
    value VARCHAR(255) NOT NULL COMMENT 'Value to compare against',
    FOREIGN KEY (election_id) REFERENCES Elections(id) ON DELETE CASCADE
);
 
CREATE TABLE Candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT COMMENT 'Can be NULL for referendum options',
    election_id INT NOT NULL,
    group_id INT COMMENT 'For candidates running in specific regions only',
    position VARCHAR(100),
    party VARCHAR(100),
    bio TEXT,
    campaign_platform TEXT,
    photo_url VARCHAR(255),
    is_referendum_option BOOLEAN DEFAULT FALSE,
    option_label VARCHAR(50) DEFAULT NULL COMMENT 'For referendums (e.g., "Yes", "No")',
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (election_id) REFERENCES Elections(id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES ElectionGroups(id) ON DELETE SET NULL,
    CHECK (
        (is_referendum_option = FALSE AND user_id IS NOT NULL) OR
        (is_referendum_option = TRUE AND option_label IS NOT NULL)
    ),
    UNIQUE (election_id, user_id)
);

select '5 election ok';
select * from ElectionResultsPerGroup;
