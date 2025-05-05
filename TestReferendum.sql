USE voting_system;

-- For Infrastructure Referendum
INSERT INTO ElectionGroups (election_id, group_name, description, score) VALUES
(4, 'Urban Zone', 'City center and immediate surroundings', 1),
(4, 'Rural Zone', 'Outlying areas of the jurisdiction', 1);



INSERT INTO Candidates (user_id, election_id, group_id, position, party, bio, campaign_platform, is_referendum_option, option_label) VALUES
(NULL, 4, NULL, NULL, NULL, NULL, 'Support the proposed infrastructure project', TRUE, 'Yes'),
(NULL, 4, NULL, NULL, NULL, NULL, 'Oppose the proposed infrastructure project', TRUE, 'No');




-- Votes for Infrastructure Referendum
-- Assign users to groups for this referendum (only 15 users)
INSERT INTO Votes (user_id, election_id, group_id, timestamp, ip_address, device_info, is_verified, verification_method) VALUES
-- Urban Zone voters
(1, 4, 12, '2024-09-01 09:00:00', '192.168.1.1', 'Chrome/Windows', TRUE, 'ID Verification'),
(3, 4, 12, '2024-09-01 09:15:00', '192.168.1.3', 'Edge/Windows', TRUE, 'ID Verification'),
(5, 4, 12, '2024-09-01 09:30:00', '192.168.1.5', 'Firefox/Windows', TRUE, 'ID Verification'),
(7, 4, 12, '2024-09-01 09:45:00', '192.168.1.7', 'Chrome/Windows', TRUE, 'ID Verification'),
(9, 4, 12, '2024-09-01 10:00:00', '192.168.1.9', 'Chrome/Windows', TRUE, 'ID Verification'),
(11, 4, 12, '2024-09-01 10:15:00', '192.168.1.11', 'Firefox/Windows', TRUE, 'ID Verification'),
(13, 4, 12, '2024-09-01 10:30:00', '192.168.1.13', 'Firefox/Linux', TRUE, 'ID Verification'),
(15, 4, 12, '2024-09-01 10:45:00', '192.168.1.15', 'Firefox/Linux', TRUE, 'ID Verification'),
-- Rural Zone voters
(2, 4, 13, '2024-09-01 09:10:00', '192.168.1.2', 'Safari/Mac', TRUE, 'ID Verification'),
(4, 4, 13, '2024-09-01 09:25:00', '192.168.1.4', 'Chrome/Windows', TRUE, 'ID Verification'),
(6, 4, 13, '2024-09-01 09:40:00', '192.168.1.6', 'Chrome/Mac', TRUE, 'ID Verification'),
(8, 4, 13, '2024-09-01 09:55:00', '192.168.1.8', 'Safari/Mac', TRUE, 'ID Verification'),
(10, 4, 13, '2024-09-01 10:10:00', '192.168.1.10', 'Safari/iOS', TRUE, 'ID Verification'),
(12, 4, 13, '2024-09-01 10:25:00', '192.168.1.12', 'Chrome/Mac', TRUE, 'ID Verification'),
(14, 4, 13, '2024-09-01 10:40:00', '192.168.1.14', 'Safari/Mac', TRUE, 'ID Verification');

-- Vote details for Referendum
INSERT INTO VoteDetails (vote_id, candidate_id, preference_order) VALUES
-- Urban Zone votes ("Yes" is candidate_id 19, "No" is candidate_id 20)
(61, 18, 1), -- Yes
(62, 18, 1), -- Yes
(63, 19, 1), -- No
(64, 18, 1), -- Yes
(65, 19, 1), -- Yes
(66, 19, 1), -- No
(67, 18, 1), -- Yes
(68, 19, 1), -- No
-- Rural Zone votes
(69, 19, 1), -- No
(70, 19, 1), -- No
(71, 18, 1), -- Yes
(72, 19, 1), -- No
(73, 19, 1), -- No
(74, 18, 1), -- Yes
(75, 19, 1); -- No


SELECT v.group_id, u.first_name AS 'user', c.option_label  
FROM VoteDetails vd
LEFT JOIN Candidates c ON c.id = vd.candidate_id
LEFT JOIN Votes v ON v.id = vd.vote_id
LEFT JOIN Users u ON u.id = v.user_id
WHERE v.election_id = 4
ORDER BY v.group_id;