USE voting_system;

-- Validation trigger for geographic hierarchy
DELIMITER //

CREATE TRIGGER validate_geographic_hierarchy
BEFORE INSERT ON NationalityAddresses
FOR EACH ROW
BEGIN
  -- Validate state belongs to country
  IF NEW.country_id != (SELECT country_id FROM States_Governorates WHERE id = NEW.states_governorates_id) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The state/governorate does not belong to the specified country.';
  END IF;

  -- Validate city belongs to state
  IF NEW.states_governorates_id != (SELECT states_governorates_id FROM Cities WHERE id = NEW.city_id) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The city does not belong to the specified state/governorate.';
  END IF;

  -- Validate district belongs to city
  IF NEW.city_id != (SELECT city_id FROM Districts WHERE id = NEW.district_id) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The district does not belong to the specified city.';
  END IF;
END//
/*
-- Trigger to enforce vote eligibility
CREATE TRIGGER check_vote_eligibility
BEFORE INSERT ON Votes
FOR EACH ROW
BEGIN
  DECLARE user_age INT;
  DECLARE election_min_age INT;
  DECLARE election_status VARCHAR(20);
  DECLARE user_eligible BOOLEAN DEFAULT FALSE;
  
  -- Check if election is active
  SELECT status, min_age INTO election_status, election_min_age 
  FROM Elections 
  WHERE id = NEW.election_id;
  
  IF election_status != 'ACTIVE' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot vote in an election that is not active.';
  END IF;
  
  -- Check user age
  SELECT TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) INTO user_age
  FROM Users
  WHERE id = NEW.user_id;
  
  IF user_age < election_min_age THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'User does not meet the minimum age requirement for this election.';
  END IF;
  
  -- Additional eligibility checks could be added here
END//

-- Trigger to enforce maximum choices per election
CREATE TRIGGER check_vote_choices
BEFORE INSERT ON VoteDetails
FOR EACH ROW
BEGIN
  DECLARE max_allowed INT;
  DECLARE current_count INT;
  DECLARE election_id INT;
  
  -- Get the election id from the vote
  SELECT v.election_id INTO election_id
  FROM Votes v
  WHERE v.id = NEW.vote_id;
  
  -- Get max choices allowed for this election
  SELECT et.max_choices INTO max_allowed
  FROM Elections e
  JOIN ElectionTypes et ON e.type_id = et.id
  WHERE e.id = election_id;
  
  -- Count existing choices for this vote
  SELECT COUNT(*) INTO current_count
  FROM VoteDetails
  WHERE vote_id = NEW.vote_id;
  
  IF current_count >= max_allowed THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Maximum number of choices exceeded for this election.';
  END IF;
END//
*/
DELIMITER ;