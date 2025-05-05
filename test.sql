SELECT v.group_id, u.first_name AS 'user', c.option_label  
FROM VoteDetails vd
LEFT JOIN Candidates c ON c.id = vd.candidate_id
LEFT JOIN Votes v ON v.id = vd.vote_id
LEFT JOIN Users u ON u.id = v.user_id
WHERE v.election_id = 4 AND v.group_id = 13
ORDER BY v.group_id;

select * from ElectionResultsPerGroup;
