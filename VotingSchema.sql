USE voting_system;

CREATE TABLE Votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    election_id INT NOT NULL,
    group_id INT NOT NULL COMMENT 'The group the voter belongs to',
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    device_info VARCHAR(255),
    is_verified BOOLEAN DEFAULT TRUE,
    verification_method VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (election_id) REFERENCES Elections(id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES ElectionGroups(id) ON DELETE CASCADE,
	UNIQUE KEY (user_id, election_id) COMMENT 'One vote per election per user'
);

CREATE TABLE VoteDetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vote_id INT NOT NULL,
    candidate_id INT NOT NULL,
    preference_order INT DEFAULT 1 COMMENT 'For ranked-choice voting',
    FOREIGN KEY (vote_id) REFERENCES Votes(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(id) ON DELETE CASCADE,
    UNIQUE KEY (vote_id, candidate_id) COMMENT 'Cannot vote for same candidate twice'
);

CREATE TABLE ElectionResultsPerGroup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    election_id INT NOT NULL,
    group_id INT COMMENT 'NULL for nationwide results',
    candidate_id INT NOT NULL,
    vote_count INT NOT NULL DEFAULT 0,
    percentage DECIMAL(5,2) COMMENT 'Percentage of votes',
    calculation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (election_id) REFERENCES Elections(id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES ElectionGroups(id) ON DELETE SET NULL,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(id) ON DELETE CASCADE
);

CREATE TABLE ElectionResults (
	id INT AUTO_INCREMENT PRIMARY KEY,
    election_id INT NOT NULL,
    candidate_id INT NOT NULL,
    vote_count INT NOT NULL DEFAULT 0,
    percentage DECIMAL(5,2) COMMENT 'Percentage of votes',
    is_winner BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (election_id) REFERENCES Elections(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(id) ON DELETE CASCADE
);

CREATE TABLE AuditLogs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(50) NOT NULL,
    user_id INT,
    target_table VARCHAR(50) NOT NULL,
    target_id INT,
    election_id INT,
    old_value TEXT,
    new_value TEXT,
    description TEXT,
    ip_address VARCHAR(45),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE SET NULL,
    FOREIGN KEY (election_id) REFERENCES Elections(id) ON DELETE SET NULL
);

select '6 voting ok';