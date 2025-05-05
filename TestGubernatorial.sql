USE voting_system;

-- For Gubernatorial Election (electoral college)
INSERT INTO ElectionGroups (election_id, group_name, description, score) VALUES
(2, 'District 1', 'Northern district with 10 electoral votes', 10),
(2, 'District 2', 'Southern district with 8 electoral votes', 8),
(2, 'District 3', 'Eastern district with 7 electoral votes', 7),
(2, 'District 4', 'Western district with 5 electoral votes', 5);


-- Candidates for Gubernatorial Election (One choice, electoral college)
INSERT INTO Candidates (user_id, election_id, group_id, position, party, bio, campaign_platform, is_referendum_option) VALUES
(2, 2, NULL, 'Governor', 'Progressive Party', 'Data scientist with innovative solutions', 'Data-driven governance and social programs', FALSE),
(6, 2, NULL, 'Governor', 'Conservative Party', 'Creative professional with fresh perspectives', 'Creative solutions to state problems', FALSE),
(10, 2, NULL, 'Governor', 'Centrist Alliance', 'Healthcare professional with community focus', 'Healthcare reform and community development', FALSE),
(14, 2, NULL, 'Governor', 'Reform Movement', 'Marketing expert with business connections', 'Economic development and business growth', FALSE);



-- Votes for Gubernatorial Election (One choice, electoral college)
-- Assign users to groups for this election
INSERT INTO Votes (user_id, election_id, group_id, timestamp, ip_address, device_info, is_verified, verification_method) VALUES
-- District 1 voters
(1, 2, 5, '2024-11-03 09:20:00', '192.168.1.1', 'Chrome/Windows', TRUE, 'ID Verification'),
(2, 2, 5, '2024-11-03 10:35:00', '192.168.1.2', 'Safari/Mac', TRUE, 'ID Verification'),
(9, 2, 5, '2024-11-03 11:50:00', '192.168.1.9', 'Chrome/Windows', TRUE, 'ID Verification'),
(10, 2, 5, '2024-11-03 13:05:00', '192.168.1.10', 'Safari/iOS', TRUE, 'ID Verification'),
(17, 2, 5, '2024-11-03 14:20:00', '192.168.1.17', 'Safari/iOS', TRUE, 'ID Verification'),
-- District 2 voters
(3, 2, 6, '2024-11-03 09:25:00', '192.168.1.3', 'Edge/Windows', TRUE, 'ID Verification'),
(4, 2, 6, '2024-11-03 10:40:00', '192.168.1.4', 'Chrome/Windows', TRUE, 'ID Verification'),
(11, 2, 6, '2024-11-03 11:55:00', '192.168.1.11', 'Firefox/Windows', TRUE, 'ID Verification'),
(12, 2, 6, '2024-11-03 13:10:00', '192.168.1.12', 'Chrome/Mac', TRUE, 'ID Verification'),
(18, 2, 6, '2024-11-03 14:25:00', '192.168.1.18', 'Chrome/Android', TRUE, 'ID Verification'),
-- District 3 voters
(5, 2, 7, '2024-11-03 09:30:00', '192.168.1.5', 'Firefox/Windows', TRUE, 'ID Verification'),
(6, 2, 7, '2024-11-03 10:45:00', '192.168.1.6', 'Chrome/Mac', TRUE, 'ID Verification'),
(13, 2, 7, '2024-11-03 12:00:00', '192.168.1.13', 'Firefox/Linux', TRUE, 'ID Verification'),
(14, 2, 7, '2024-11-03 13:15:00', '192.168.1.14', 'Safari/Mac', TRUE, 'ID Verification'),
(19, 2, 7, '2024-11-03 14:30:00', '192.168.1.19', 'Edge/Windows', TRUE, 'ID Verification'),
-- District 4 voters
(7, 2, 8, '2024-11-03 09:35:00', '192.168.1.7', 'Chrome/Windows', TRUE, 'ID Verification'),
(8, 2, 8, '2024-11-03 10:50:00', '192.168.1.8', 'Safari/Mac', TRUE, 'ID Verification'),
(15, 2, 8, '2024-11-03 12:05:00', '192.168.1.15', 'Firefox/Linux', TRUE, 'ID Verification'),
(16, 2, 8, '2024-11-03 13:20:00', '192.168.1.16', 'Chrome/Android', TRUE, 'ID Verification'),
(20, 2, 8, '2024-11-03 14:35:00', '192.168.1.20', 'Safari/iOS', TRUE, 'ID Verification');

-- Vote details for Gubernatorial Election
INSERT INTO VoteDetails (vote_id, candidate_id, preference_order) VALUES
(21, 5, 1),
(22, 6, 1),
(23, 5, 1),
(24, 7, 1),
(25, 5, 1),
(26, 5, 1),
(27, 6, 1),
(28, 8, 1),
(29, 7, 1),
(30, 7, 1),
(31, 6, 1),
(32, 6, 1),
(33, 8, 1),
(34, 8, 1),
(35, 7, 1),
(36, 5, 1),
(37, 6, 1),
(38, 7, 1),
(39, 8, 1),
(40, 8, 1);
