USE voting_system;

-- Candidates for Presidential Election (One choice, popular vote)

DELETE FROM Candidates;
DELETE FROM Votes;
DELETE FROM VoteDetails;


-- For Presidential Election (popular vote)
INSERT INTO ElectionGroups (election_id, group_name, description, score) VALUES
(1, 'Western Region', 'States in the western part of the country', 1),
(1, 'Eastern Region', 'States in the eastern part of the country', 1),
(1, 'Northern Region', 'States in the northern part of the country', 1),
(1, 'Southern Region', 'States in the southern part of the country', 1);


INSERT INTO Candidates (user_id, election_id, group_id, position, party, bio, campaign_platform, is_referendum_option) VALUES
(1, 1, NULL, 'President', 'Progressive Party', 'Experienced technology executive with a focus on innovation', 'Technological advancement and economic equality', FALSE),
(5, 1, NULL, 'President', 'Conservative Party', 'Former city manager with extensive public service', 'Fiscal responsibility and traditional values', FALSE),
(9, 1, NULL, 'President', 'Centrist Alliance', 'Banking professional with economic expertise', 'Balanced approach to growth and regulation', FALSE),
(13, 1, NULL, 'President', 'Reform Movement', 'Policy expert with international experience', 'Government reform and international cooperation', FALSE);


-- Votes for Presidential Election (One choice, popular vote)
-- Assign users to groups for this election
INSERT INTO Votes (user_id, election_id, group_id, timestamp, ip_address, device_info, is_verified, verification_method) VALUES
-- Western Region voters
(1, 1, 1, '2024-11-03 09:15:00', '192.168.1.1', 'Chrome/Windows', TRUE, 'ID Verification'),
(2, 1, 1, '2024-11-03 10:30:00', '192.168.1.2', 'Safari/Mac', TRUE, 'ID Verification'),
(5, 1, 1, '2024-11-03 11:45:00', '192.168.1.5', 'Firefox/Windows', TRUE, 'ID Verification'),
(6, 1, 1, '2024-11-03 12:15:00', '192.168.1.6', 'Chrome/Mac', TRUE, 'ID Verification'),
(17, 1, 1, '2024-11-03 13:30:00', '192.168.1.17', 'Safari/iOS', TRUE, 'ID Verification'),
-- Eastern Region voters
(3, 1, 2, '2024-11-03 09:00:00', '192.168.1.3', 'Edge/Windows', TRUE, 'ID Verification'),
(4, 1, 2, '2024-11-03 10:15:00', '192.168.1.4', 'Chrome/Windows', TRUE, 'ID Verification'),
(13, 1, 2, '2024-11-03 11:30:00', '192.168.1.13', 'Firefox/Linux', TRUE, 'ID Verification'),
(14, 1, 2, '2024-11-03 12:45:00', '192.168.1.14', 'Safari/Mac', TRUE, 'ID Verification'),
(18, 1, 2, '2024-11-03 14:00:00', '192.168.1.18', 'Chrome/Android', TRUE, 'ID Verification'),
-- Northern Region voters
(9, 1, 3, '2024-11-03 09:30:00', '192.168.1.9', 'Chrome/Windows', TRUE, 'ID Verification'),
(10, 1, 3, '2024-11-03 10:45:00', '192.168.1.10', 'Safari/iOS', TRUE, 'ID Verification'),
(11, 1, 3, '2024-11-03 12:00:00', '192.168.1.11', 'Firefox/Windows', TRUE, 'ID Verification'),
(12, 1, 3, '2024-11-03 13:15:00', '192.168.1.12', 'Chrome/Mac', TRUE, 'ID Verification'),
(19, 1, 3, '2024-11-03 14:30:00', '192.168.1.19', 'Edge/Windows', TRUE, 'ID Verification'),
-- Southern Region voters
(7, 1, 4, '2024-11-03 09:45:00', '192.168.1.7', 'Chrome/Windows', TRUE, 'ID Verification'),
(8, 1, 4, '2024-11-03 11:00:00', '192.168.1.8', 'Safari/Mac', TRUE, 'ID Verification'),
(15, 1, 4, '2024-11-03 12:30:00', '192.168.1.15', 'Firefox/Linux', TRUE, 'ID Verification'),
(16, 1, 4, '2024-11-03 13:45:00', '192.168.1.16', 'Chrome/Android', TRUE, 'ID Verification'),
(20, 1, 4, '2024-11-03 15:00:00', '192.168.1.20', 'Safari/iOS', TRUE, 'ID Verification');


-- Vote details for Presidential Election
INSERT INTO VoteDetails (vote_id, candidate_id, preference_order) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 1),
(4, 1, 1),
(5, 3, 1),
(6, 1, 1),
(7, 3, 1),
(8, 2, 1),
(9, 3, 1),
(10, 3, 1),
(11, 4, 1),
(12, 4, 1),
(13, 1, 1),
(14, 2, 1),
(15, 2, 1),
(16, 4, 1),
(17, 4, 1),
(18, 3, 1),
(19, 2, 1),
(20, 1, 1);

SELECT v.group_id, u.first_name AS 'user', uc.first_name AS 'candidate' 
FROM VoteDetails vd
LEFT JOIN Candidates c ON c.id = vd.candidate_id
LEFT JOIN Votes v ON v.id = vd.vote_id
LEFT JOIN Users u ON u.id = v.user_id
LEFT JOIN Users uc ON uc.id = c.user_id
ORDER BY v.group_id;


