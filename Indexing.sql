USE voting_system;

-- Create necessary indexes for performance
CREATE INDEX idx_states_country ON States_Governorates(country_id);
CREATE INDEX idx_cities_state ON Cities(states_governorates_id);
CREATE INDEX idx_districts_city ON Districts(city_id);
CREATE INDEX idx_nationality_location ON NationalityAddresses(country_id, states_governorates_id, city_id);
CREATE INDEX idx_user_education ON UserEducation(user_id);
CREATE INDEX idx_enrolled_user ON EnrolledIN(user_id);
CREATE INDEX idx_election_type ON Elections(type_id);
CREATE INDEX idx_election_dates ON Elections(start_date, end_date);
CREATE INDEX idx_candidates_election ON Candidates(election_id);
CREATE INDEX idx_votes_election ON VoteDetails(election_id);
CREATE INDEX idx_votes_user ON VoteDetails(user_id);
CREATE INDEX idx_vote_details_vote ON Votes(vote_id);
CREATE INDEX idx_results_election ON ElectionResultsPerGroup(election_id);
CREATE INDEX idx_audit_election ON AuditLogs(election_id);

CREATE INDEX idx_election_results_winner ON ElectionResults(election_id, is_winner);
CREATE INDEX idx_candidates_group ON Candidates(group_id);
CREATE INDEX idx_vote_details_candidate ON Votes(candidate_id);
CREATE INDEX idx_nationalities_user ON Nationalities(user_id);

select 66;