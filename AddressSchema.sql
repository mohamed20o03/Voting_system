USE voting_system;

-- Geographic hierarchy tables
CREATE TABLE Countries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    code VARCHAR(3) UNIQUE COMMENT 'Country code (ISO)'
);

CREATE TABLE States_Governorates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES Countries(id) ON DELETE CASCADE,
    UNIQUE KEY (country_id, name)
);

CREATE TABLE Cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    states_governorates_id INT NOT NULL,
    FOREIGN KEY (states_governorates_id) REFERENCES States_Governorates(id) ON DELETE CASCADE,
    UNIQUE KEY (states_governorates_id, name)
);

CREATE TABLE Districts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES Cities(id) ON DELETE CASCADE,
    UNIQUE KEY (city_id, name)
);

-- Nationality and user identity tables
CREATE TABLE NationalityAddresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT NOT NULL,
    states_governorates_id INT NOT NULL,
    city_id INT NOT NULL,
    district_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES Countries(id) ON DELETE CASCADE,
    FOREIGN KEY (states_governorates_id) REFERENCES States_Governorates(id) ON DELETE CASCADE,
    FOREIGN KEY (city_id) REFERENCES Cities(id) ON DELETE CASCADE,
    FOREIGN KEY (district_id) REFERENCES Districts(id) ON DELETE CASCADE
);

select 'address ok';