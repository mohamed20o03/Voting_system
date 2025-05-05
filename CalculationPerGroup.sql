USE voting_system;



-- Function to calculate election results per groups based on type
DELIMITER //
CREATE PROCEDURE calculate_election_results_per_group(IN p_election_id INT)
BEGIN

  DECLARE v_error VARCHAR(255);

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_error = MESSAGE_TEXT;
    INSERT INTO AuditLogs (action_type, target_table, target_id, election_id, description)
    VALUES ('ERROR', 'ElectionResultsPerGroup', NULL, p_election_id, CONCAT('Error calculating results: ', v_error));
  END;

  -- Clear existing results
  DELETE FROM ElectionResultsPerGroup WHERE election_id = p_election_id;

  -- Start transaction
  START TRANSACTION;

  -- Calculate results based on election type
		INSERT INTO ElectionResultsPerGroup (election_id, group_id , candidate_id, vote_count, percentage)

		  WITH TotalVotesPerGroup AS (
        SELECT v.group_id, COUNT(*) AS total_votes
        FROM VoteDetails vd
        JOIN Votes v ON vd.vote_id = v.id
        WHERE v.election_id = p_election_id
        GROUP BY v.group_id
      )

      SELECT 
        p_election_id AS election_id,
        v.group_id,
        c.id AS candidate_id,
        COUNT(vd.id) AS vote_count,
        CASE 
          WHEN tv.total_votes = 0 OR tv.total_votes IS NULL THEN 0
          ELSE COUNT(vd.id) * 100.0 / tv.total_votes
        END AS percentage
      FROM Candidates c
      LEFT JOIN VoteDetails vd ON c.id = vd.candidate_id
      LEFT JOIN Votes v ON vd.vote_id = v.id AND v.election_id = p_election_id
      LEFT JOIN TotalVotesPerGroup tv ON v.group_id = tv.group_id
      WHERE c.election_id = p_election_id
      GROUP BY v.group_id, c.id, tv.total_votes
      ORDER BY v.group_id, c.id;
        


  -- Update total voters count
  UPDATE Elections
  SET total_voters = (SELECT COUNT(*) FROM Votes WHERE election_id = p_election_id)
  WHERE id = p_election_id;

  -- Insert calculation log
  INSERT INTO AuditLogs (action_type, target_table, target_id, election_id, description)
  VALUES ('CALCULATE_RESULTS', 'ElectionResultsPerGroup', NULL, p_election_id, 'Election results calculated');

  -- Commit transaction
  COMMIT;
END//

DELIMITER ;


select 'nagat';

DELIMITER //

-- Function to calculate election results based on type
CREATE PROCEDURE calculate_final_election_results(IN p_election_id INT)
BEGIN
  DECLARE election_type VARCHAR(20);
  DECLARE seats INT;
  DECLARE v_error VARCHAR(255);


  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
  BEGIN
    GET DIAGNOSTICS CONDITION 1 v_error = MESSAGE_TEXT;
    INSERT INTO AuditLogs (action_type, target_table, target_id, election_id, description)
    VALUES ('ERROR', 'ElectionResults', NULL, p_election_id, CONCAT('Error calculating results: ', v_error));
  END;

  -- Get the election type
  SELECT et.vote_count_method, et.max_choices INTO election_type, seats  FROM Elections e
  JOIN ElectionTypes et ON e.type_id = et.id
  WHERE e.id = p_election_id;

  -- Clear existing results
  DELETE FROM ElectionResults WHERE election_id = p_election_id;

  -- Start transaction
  START TRANSACTION;

  -- Calculate results based on election type

  -- Calculate results by popular vote
	IF election_type = 'POPULAR_VOTE' THEN

		INSERT INTO ElectionResults (election_id, candidate_id, vote_count, percentage, is_winner)

		  SELECT 
		    election_id,
        candidate_id,
        SUM(vote_count) AS total_votes,
        CASE 
			  WHEN (SELECT SUM(vote_count) FROM ElectionResultsPerGroup WHERE election_id = p_election_id) = 0 THEN 0
			  ELSE ROUND(
               SUM(vote_count) * 100.0 /
                  (SELECT SUM(vote_count) FROM ElectionResultsPerGroup WHERE election_id = p_election_id),
              2
              )
				END AS percentage,
        0
      FROM ElectionResultsPerGroup erg
      WHERE election_id = p_election_id
      GROUP BY election_id, candidate_id
      ORDER BY total_votes DESC;
		  
    
		    
  -- Calculate results by Electoral college
  ELSE

    
SET @total_score_sum = (
  SELECT SUM(score)
  FROM ElectionGroups
  WHERE election_id = p_election_id
);

    INSERT INTO ElectionResults (election_id, candidate_id, vote_count, percentage, is_winner)
    SELECT 
      p_election_id,
      erg.candidate_id,
      SUM(g.score) AS total_score,
      CASE 
        WHEN @total_score_sum = 0 THEN 0
        ELSE ROUND(SUM(g.score) * 100.0 / @total_score_sum, 2)
      END AS percentage,
      0 AS is_winner
    FROM ElectionResultsPerGroup erg
    JOIN (
      SELECT group_id, MAX(vote_count) AS max_votes
      FROM ElectionResultsPerGroup
      WHERE election_id = p_election_id
      GROUP BY group_id
    ) top
      ON erg.group_id = top.group_id AND erg.vote_count = top.max_votes
    JOIN ElectionGroups g
      ON erg.group_id = g.id
    WHERE erg.election_id = p_election_id
    GROUP BY erg.candidate_id;
    

    END IF;

    UPDATE ElectionResults er
    JOIN (
      SELECT candidate_id
      FROM (
        SELECT candidate_id, vote_count,
              RANK() OVER (ORDER BY vote_count DESC) AS rnk
        FROM ElectionResults
        WHERE election_id = p_election_id
      ) ranked
      WHERE rnk <= seats
    ) winners
    ON er.candidate_id = winners.candidate_id AND er.election_id = p_election_id
    SET er.is_winner = 1;


  -- Insert calculation log
  INSERT INTO AuditLogs (action_type, target_table, target_id, election_id, description)
  VALUES ('CALCULATE_RESULTS', 'ElectionResults', NULL, p_election_id, 'Election results calculated');

  -- Commit transaction
  COMMIT;
END//

DELIMITER ;
