USE voting_system;

-- For City Council Election (multi-choice)
INSERT INTO ElectionGroups (election_id, group_name, description, score) VALUES
(3, 'Downtown District', 'Central city area', 1),
(3, 'Suburban District', 'Surrounding suburbs', 1),
(3, 'Commercial District', 'Business and retail areas', 1);


-- Candidates for City Council Election (Multi-choice, popular vote)
INSERT INTO Candidates (user_id, election_id, group_id, position, party, bio, campaign_platform, is_referendum_option) VALUES
(3, 3, 1, 'Council Member', 'Progressive Party', 'Professor with focus on urban issues', 'Educational investment and urban renewal', FALSE),
(4, 3, 1, 'Council Member', 'Conservative Party', 'English teacher with community ties', 'Community values and educational excellence', FALSE),
(7, 3, 1, 'Council Member', 'Independent', 'Engineer with infrastructure expertise', 'Infrastructure improvement and efficiency', FALSE),
(8, 3, 2, 'Council Member', 'Progressive Party', 'Communications specialist with outreach experience', 'Improved communication and transparency', FALSE),
(11, 3, 2, 'Council Member', 'Conservative Party', 'Mathematics expert with analytical skills', 'Analytical approach to suburban challenges', FALSE),
(12, 3, 2, 'Council Member', 'Independent', 'Public health advocate', 'Health-focused community development', FALSE),
(15, 3, 3, 'Council Member', 'Progressive Party', 'Former police officer with safety focus', 'Public safety and business development', FALSE),
(16, 3, 3, 'Council Member', 'Conservative Party', 'Biology teacher with environmental concerns', 'Environmental protection and business growth', FALSE),
(19, 3, 3, 'Council Member', 'Independent', 'Urban planning expert', 'Strategic development of commercial areas', FALSE);



-- Votes for City Council Election (Multi-choice, popular vote)
-- Assign users to groups for this election
INSERT INTO Votes (user_id, election_id, group_id, timestamp, ip_address, device_info, is_verified, verification_method) VALUES
-- Downtown District voters
(1, 3, 9, '2024-10-15 09:00:00', '192.168.1.1', 'Chrome/Windows', TRUE, 'ID Verification'),
(2, 3, 9, '2024-10-15 09:30:00', '192.168.1.2', 'Safari/Mac', TRUE, 'ID Verification'),
(3, 3, 9, '2024-10-15 10:00:00', '192.168.1.3', 'Edge/Windows', TRUE, 'ID Verification'),
(4, 3, 9, '2024-10-15 10:30:00', '192.168.1.4', 'Chrome/Windows', TRUE, 'ID Verification'),
(5, 3, 9, '2024-10-15 11:00:00', '192.168.1.5', 'Firefox/Windows', TRUE, 'ID Verification'),
(6, 3, 9, '2024-10-15 11:30:00', '192.168.1.6', 'Chrome/Mac', TRUE, 'ID Verification'),
(7, 3, 9, '2024-10-15 12:00:00', '192.168.1.7', 'Chrome/Windows', TRUE, 'ID Verification'),
-- Suburban District voters
(8, 3, 10, '2024-10-15 09:15:00', '192.168.1.8', 'Safari/Mac', TRUE, 'ID Verification'),
(9, 3, 10, '2024-10-15 09:45:00', '192.168.1.9', 'Chrome/Windows', TRUE, 'ID Verification'),
(10, 3, 10, '2024-10-15 10:15:00', '192.168.1.10', 'Safari/iOS', TRUE, 'ID Verification'),
(11, 3, 10, '2024-10-15 10:45:00', '192.168.1.11', 'Firefox/Windows', TRUE, 'ID Verification'),
(12, 3, 10, '2024-10-15 11:15:00', '192.168.1.12', 'Chrome/Mac', TRUE, 'ID Verification'),
(13, 3, 10, '2024-10-15 11:45:00', '192.168.1.13', 'Firefox/Linux', TRUE, 'ID Verification'),
-- Commercial District voters
(14, 3, 11, '2024-10-15 09:10:00', '192.168.1.14', 'Safari/Mac', TRUE, 'ID Verification'),
(15, 3, 11, '2024-10-15 09:40:00', '192.168.1.15', 'Firefox/Linux', TRUE, 'ID Verification'),
(16, 3, 11, '2024-10-15 10:10:00', '192.168.1.16', 'Chrome/Android', TRUE, 'ID Verification'),
(17, 3, 11, '2024-10-15 10:40:00', '192.168.1.17', 'Safari/iOS', TRUE, 'ID Verification'),
(18, 3, 11, '2024-10-15 11:10:00', '192.168.1.18', 'Chrome/Android', TRUE, 'ID Verification'),
(19, 3, 11, '2024-10-15 11:40:00', '192.168.1.19', 'Edge/Windows', TRUE, 'ID Verification'),
(20, 3, 11, '2024-10-15 12:10:00', '192.168.1.20', 'Safari/iOS', TRUE, 'ID Verification');

-- Vote details for City Council Election (showing multi-choice with 2 votes per person)
INSERT INTO VoteDetails (vote_id, candidate_id, preference_order) VALUES
-- Downtown District votes
(41, 9, 1),
(41, 11, 2),
(42, 9, 1),
(42, 10, 2),
(43, 10, 1),
(43, 11, 2),
(44, 10, 1),
(44, 9, 2),
(45, 11, 1),
(45, 9, 2),
(46, 11, 1),
(46, 10, 2),
(47, 9, 1),
(47, 11, 2),
-- Suburban District votes
(48, 12, 1),
(48, 14, 2),
(49, 13, 1),
(49, 12, 2),
(50, 13, 1),
(50, 14, 2),
(51, 14, 1),
(51, 12, 2),
(52, 14, 1),
(52, 13, 2),
(53, 12, 1),
(53, 13, 2),
-- Commercial District votes
(54, 15, 1),
(54, 17, 2),
(55, 17, 1),
(55, 16, 2),
(56, 16, 1),
(56, 15, 2),
(57, 17, 1),
(57, 15, 2),
(58, 15, 1),
(58, 16, 2),
(59, 16, 1),
(59, 17, 2),
(60, 17, 1),
(60, 16, 2);

