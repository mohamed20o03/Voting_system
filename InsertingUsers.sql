USE voting_system;

INSERT INTO Countries (name, code) VALUES
('United States', 'USA'),
('Canada', 'CAN'),
('United Kingdom', 'GBR'),
('Australia', 'AUS');

INSERT INTO States_Governorates (name, country_id) VALUES
('California', 1),
('New York', 1),
('Texas', 1),
('Florida', 1),
('Ontario', 2),
('British Columbia', 2),
('England', 3),
('Scotland', 3),
('New South Wales', 4),
('Victoria', 4);

INSERT INTO Cities (name, states_governorates_id) VALUES
('Los Angeles', 1),
('San Francisco', 1),
('New York City', 2),
('Buffalo', 2),
('Houston', 3),
('Austin', 3),
('Miami', 4),
('Orlando', 4),
('Toronto', 5),
('Ottawa', 5),
('Vancouver', 6),
('Victoria', 6),
('London', 7),
('Manchester', 7),
('Edinburgh', 8),
('Glasgow', 8),
('Sydney', 9),
('Newcastle', 9),
('Melbourne', 10),
('Geelong', 10);

INSERT INTO Districts (name, city_id) VALUES
('Downtown', 1),
('Hollywood', 1),
('Marina District', 2),
('Mission District', 2),
('Manhattan', 3),
('Brooklyn', 3),
('North Buffalo', 4),
('South Buffalo', 4),
('Downtown Houston', 5),
('Midtown', 5),
('South Congress', 6),
('East Austin', 6),
('South Beach', 7),
('Little Havana', 7),
('Downtown Orlando', 8),
('Lake Nona', 8),
('Downtown Toronto', 9),
('North York', 9),
('Downtown Ottawa', 10),
('Kanata', 10),
('Downtown Vancouver', 11),
('Kitsilano', 11),
('Downtown Victoria', 12),
('Oak Bay', 12),
('Central London', 13),
('Kensington', 13),
('Northern Quarter', 14),
('Ancoats', 14),
('Old Town', 15),
('Leith', 15),
('West End', 16),
('Merchant City', 16),
('CBD', 17),
('Bondi', 17),
('Newcastle East', 18),
('Newcastle West', 18),
('CBD', 19),
('St Kilda', 19),
('Geelong Central', 20),
('Newtown', 20);

INSERT INTO NationalityAddresses (country_id, states_governorates_id, city_id, district_id) VALUES
(1, 1, 1, 1),
(1, 1, 2, 3),
(1, 2, 3, 5),
(1, 2, 4, 7),
(1, 3, 5, 9),
(1, 3, 6, 11),
(1, 4, 7, 13),
(1, 4, 8, 15),
(2, 5, 9, 17),
(2, 5, 10, 19),
(2, 6, 11, 21),
(2, 6, 12, 23),
(3, 7, 13, 25),
(3, 7, 14, 27),
(3, 8, 15, 29),
(3, 8, 16, 31),
(4, 9, 17, 33),
(4, 9, 18, 35),
(4, 10, 19, 37),
(4, 10, 20, 39);

-- Job categories, fields, jobs, sectors, and organizations
INSERT INTO JobCategories (name) VALUES
('Technology'),
('Healthcare'),
('Education'),
('Finance'),
('Government');

INSERT INTO Fields (name, category_id) VALUES
('Software Development', 1),
('Data Science', 1),
('Medicine', 2),
('Nursing', 2),
('K-12 Education', 3),
('Higher Education', 3),
('Banking', 4),
('Investment', 4),
('Public Administration', 5),
('Public Safety', 5);

INSERT INTO Jobs (name, field_id) VALUES
('Software Engineer', 1),
('Web Developer', 1),
('Data Analyst', 2),
('Machine Learning Engineer', 2),
('Physician', 3),
('Surgeon', 3),
('Registered Nurse', 4),
('Nurse Practitioner', 4),
('Teacher', 5),
('Principal', 5),
('Professor', 6),
('Academic Dean', 6),
('Bank Teller', 7),
('Loan Officer', 7),
('Financial Analyst', 8),
('Investment Banker', 8),
('City Manager', 9),
('Policy Analyst', 9),
('Police Officer', 10),
('Firefighter', 10);

INSERT INTO Sectors (name) VALUES
('Public'),
('Private'),
('Non-profit'),
('Academic');

INSERT INTO Organizations (name, sector_id) VALUES
('Google', 2),
('Microsoft', 2),
('City Hospital', 1),
('Private Medical Center', 2),
('Public School District', 1),
('Private University', 4),
('National Bank', 2),
('Investment Firm', 2),
('City Government', 1),
('Federal Agency', 1);

-- Education levels
INSERT INTO EducationLevels (level_name, description) VALUES
('High School', 'Secondary education diploma'),
('Associate Degree', '2-year undergraduate degree'),
('Bachelor\'s Degree', '4-year undergraduate degree'),
('Master\'s Degree', 'Graduate degree'),
('Doctorate', 'Highest academic degree');

-- Users
INSERT INTO Users (first_name, middle_name, last_name, gender, birth_date, email, phone, current_address, is_active, account_verified, profile_image) VALUES
('John', 'David', 'Smith', 'male', '1985-03-15', 'john.smith@email.com', '555-1234', '123 Main St, Los Angeles', TRUE, TRUE, 'john_profile.jpg'),
('Sarah', 'Lynn', 'Johnson', 'female', '1990-07-22', 'sarah.johnson@email.com', '555-2345', '456 Oak Ave, San Francisco', TRUE, TRUE, 'sarah_profile.jpg'),
('Michael', NULL, 'Williams', 'male', '1978-11-05', 'michael.williams@email.com', '555-3456', '789 Broadway, New York', TRUE, TRUE, 'michael_profile.jpg'),
('Emily', 'Rose', 'Brown', 'female', '1992-05-18', 'emily.brown@email.com', '555-4567', '101 Pine St, Buffalo', TRUE, TRUE, 'emily_profile.jpg'),
('Robert', 'James', 'Jones', 'male', '1983-09-30', 'robert.jones@email.com', '555-5678', '202 Elm St, Houston', TRUE, TRUE, 'robert_profile.jpg'),
('Jessica', 'Anne', 'Miller', 'female', '1995-01-12', 'jessica.miller@email.com', '555-6789', '303 Cedar Rd, Austin', TRUE, TRUE, 'jessica_profile.jpg'),
('William', 'Thomas', 'Davis', 'male', '1980-06-24', 'william.davis@email.com', '555-7890', '404 Palm Ave, Miami', TRUE, TRUE, 'william_profile.jpg'),
('Jennifer', NULL, 'Garcia', 'female', '1993-12-07', 'jennifer.garcia@email.com', '555-8901', '505 Orange Blvd, Orlando', TRUE, TRUE, 'jennifer_profile.jpg'),
('David', 'Alan', 'Rodriguez', 'male', '1987-04-19', 'david.rodriguez@email.com', '555-9012', '606 Maple St, Toronto', TRUE, TRUE, 'david_profile.jpg'),
('Lisa', 'Marie', 'Wilson', 'female', '1991-08-26', 'lisa.wilson@email.com', '555-0123', '707 Birch Ave, Ottawa', TRUE, TRUE, 'lisa_profile.jpg'),
('James', 'Edward', 'Taylor', 'male', '1979-02-08', 'james.taylor@email.com', '555-1234', '808 Walnut Rd, Vancouver', TRUE, TRUE, 'james_profile.jpg'),
('Emma', 'Claire', 'Anderson', 'female', '1994-10-31', 'emma.anderson@email.com', '555-2345', '909 Pine St, Victoria', TRUE, TRUE, 'emma_profile.jpg'),
('Charles', NULL, 'Thomas', 'male', '1982-12-13', 'charles.thomas@email.com', '555-3456', '110 Oxford St, London', TRUE, TRUE, 'charles_profile.jpg'),
('Sophia', 'Grace', 'Jackson', 'female', '1996-06-05', 'sophia.jackson@email.com', '555-4567', '211 Market St, Manchester', TRUE, TRUE, 'sophia_profile.jpg'),
('Daniel', 'Joseph', 'White', 'male', '1984-11-17', 'daniel.white@email.com', '555-5678', '312 Royal Mile, Edinburgh', TRUE, TRUE, 'daniel_profile.jpg'),
('Olivia', 'Jane', 'Harris', 'female', '1989-03-29', 'olivia.harris@email.com', '555-6789', '413 Buchanan St, Glasgow', TRUE, TRUE, 'olivia_profile.jpg'),
('Matthew', 'Philip', 'Martin', 'male', '1981-07-02', 'matthew.martin@email.com', '555-7890', '514 George St, Sydney', TRUE, TRUE, 'matthew_profile.jpg'),
('Ava', NULL, 'Thompson', 'female', '1997-01-14', 'ava.thompson@email.com', '555-8901', '615 Hunter St, Newcastle', TRUE, TRUE, 'ava_profile.jpg'),
('Andrew', 'Ryan', 'Garcia', 'male', '1988-09-23', 'andrew.garcia@email.com', '555-9012', '716 Collins St, Melbourne', TRUE, TRUE, 'andrew_profile.jpg'),
('Isabella', 'Marie', 'Robinson', 'female', '1993-05-08', 'isabella.robinson@email.com', '555-0123', '817 Ryrie St, Geelong', TRUE, TRUE, 'isabella_profile.jpg');

-- Nationalities (National IDs)
INSERT INTO Nationalities (national_id, user_id, nationality_address_id) VALUES
('USA123456789', 1, 1),
('USA234567890', 2, 2),
('USA345678901', 3, 3),
('USA456789012', 4, 4),
('USA567890123', 5, 5),
('USA678901234', 6, 6),
('USA789012345', 7, 7),
('USA890123456', 8, 8),
('CAN901234567', 9, 9),
('CAN012345678', 10, 10),
('CAN123456789', 11, 11),
('CAN234567890', 12, 12),
('GBR345678901', 13, 13),
('GBR456789012', 14, 14),
('GBR567890123', 15, 15),
('GBR678901234', 16, 16),
('AUS789012345', 17, 17),
('AUS890123456', 18, 18),
('AUS901234567', 19, 19),
('AUS012345678', 20, 20);

-- User Education
INSERT INTO UserEducation (user_id, education_level_id, major, start_date, end_date, is_current, gpa) VALUES
(1, 3, 'Computer Science', '2003-09-01', '2007-06-01', FALSE, 3.75),
(2, 4, 'Psychology', '2008-09-01', '2010-06-01', FALSE, 3.90),
(3, 5, 'Physics', '1996-09-01', '2001-06-01', FALSE, 3.85),
(4, 3, 'English Literature', '2010-09-01', '2014-06-01', FALSE, 3.70),
(5, 3, 'Business Administration', '2001-09-01', '2005-06-01', FALSE, 3.60),
(6, 4, 'Graphic Design', '2013-09-01', '2015-06-01', FALSE, 3.95),
(7, 3, 'Engineering', '1998-09-01', '2002-06-01', FALSE, 3.80),
(8, 3, 'Communications', '2011-09-01', '2015-06-01', FALSE, 3.75),
(9, 4, 'Economics', '2005-09-01', '2007-06-01', FALSE, 3.70),
(10, 3, 'Nursing', '2009-09-01', '2013-06-01', FALSE, 3.85),
(11, 5, 'Mathematics', '1997-09-01', '2002-06-01', FALSE, 3.90),
(12, 4, 'Public Health', '2012-09-01', '2014-06-01', FALSE, 3.80),
(13, 3, 'History', '2000-09-01', '2004-06-01', FALSE, 3.65),
(14, 3, 'Marketing', '2014-09-01', '2018-06-01', FALSE, 3.75),
(15, 4, 'International Relations', '2002-09-01', '2004-06-01', FALSE, 3.70),
(16, 3, 'Biology', '2007-09-01', '2011-06-01', FALSE, 3.80),
(17, 5, 'Chemistry', '1999-09-01', '2004-06-01', FALSE, 3.85),
(18, 3, 'Art History', '2015-09-01', '2019-06-01', FALSE, 3.90),
(19, 4, 'Urban Planning', '2006-09-01', '2008-06-01', FALSE, 3.75),
(20, 3, 'Environmental Science', '2011-09-01', '2015-06-01', FALSE, 3.70);

-- Job Enrollments
INSERT INTO EnrolledIN (user_id, job_id, organization_id, seniority_level, start_date, end_date) VALUES
(1, 1, 1, 'Senior', '2007-07-01', NULL),
(2, 3, 1, 'Mid Level', '2010-07-01', NULL),
(3, 11, 6, 'Lead', '2001-08-01', NULL),
(4, 9, 5, 'Mid Level', '2014-07-01', NULL),
(5, 17, 9, 'Manager', '2005-08-01', NULL),
(6, 2, 2, 'Junior', '2015-07-01', NULL),
(7, 15, 8, 'Senior', '2002-08-01', NULL),
(8, 9, 5, 'Junior', '2015-08-01', NULL),
(9, 13, 7, 'Mid Level', '2007-08-01', NULL),
(10, 7, 3, 'Senior', '2013-07-01', NULL),
(11, 4, 2, 'Lead', '2002-09-01', NULL),
(12, 8, 4, 'Mid Level', '2014-08-01', NULL),
(13, 18, 10, 'Director', '2004-09-01', NULL),
(14, 14, 7, 'Junior', '2018-07-01', NULL),
(15, 19, 9, 'Senior', '2004-08-01', NULL),
(16, 7, 4, 'Mid Level', '2011-08-01', NULL),
(17, 6, 3, 'Executive', '2004-09-01', NULL),
(18, 2, 1, 'Entry Level', '2019-07-01', NULL),
(19, 15, 8, 'Manager', '2008-09-01', NULL),
(20, 9, 6, 'Junior', '2015-08-01', NULL);

-- Election Types
INSERT INTO ElectionTypes (type_name, vote_count_method, max_choices, description) VALUES
('ONE_CHOICE', 'POPULAR_VOTE', 1, 'One choice per voter, determined by popular vote'),
('ONE_CHOICE', 'ELECTORAL_COLLEGE', 1, 'One choice per voter, determined by electoral college'),
('MULTI_CHOICE', 'POPULAR_VOTE', 2, 'Up to two choices per voter, determined by popular vote'),
('REFERENDUM', 'POPULAR_VOTE', 1, 'Yes/No referendum, determined by popular vote');

-- Elections
INSERT INTO Elections (election_name, type_id, start_date, end_date, description, status, created_by, total_voters) VALUES
('Presidential Election 2024', 1, '2024-11-03 07:00:00', '2024-11-03 20:00:00', 'National presidential election by popular vote', 'COMPLETED', 1, 20),
('Gubernatorial Election 2024', 2, '2024-11-03 07:00:00', '2024-11-03 20:00:00', 'State governor election using electoral college', 'COMPLETED', 3, 20),
('City Council Election 2024', 3, '2024-10-15 07:00:00', '2024-10-15 20:00:00', 'City council election with multiple seats', 'COMPLETED', 5, 20),
('Infrastructure Referendum', 4, '2024-09-01 07:00:00', '2024-09-01 20:00:00', 'Referendum on city infrastructure project', 'COMPLETED', 13, 15);



-- Election Eligibility
INSERT INTO ElectionEligibility (election_id, attribute, condition_type, value) VALUES
(1, 'age', 'GREATER_THAN', '18'),
(1, 'country_id', 'EQUALS', '1'),
(2, 'age', 'GREATER_THAN', '18'),
(2, 'country_id', 'EQUALS', '1'),
(3, 'age', 'GREATER_THAN', '18'),
(3, 'country_id', 'IN', '1,2,3,4'),
(4, 'age', 'GREATER_THAN', '18'),
(4, 'country_id', 'IN', '1,2');


