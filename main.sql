-- Database creation
DROP DATABASE IF EXISTS voting_system;
CREATE DATABASE voting_system;
USE voting_system;

source ./AddressSchema.sql;

source ./EducationSchema.sql;

source ./JobSchema.sql;

source ./UserSchema.sql;

source ./ElectionSchema.sql;

source ./VotingSchema.sql;

source ./Indexing.sql;


source ./Procedures.sql;

source ./InsertingUsers.sql;
source ./TestPresidential.sql;
source ./TestGubernatorial.sql;
source ./TestCouncil.sql;
source ./TestReferendum.sql;

source ./CalculationPerGroup.sql;

CALL calculate_election_results_per_group(1);
CALL calculate_election_results_per_group(2);
CALL calculate_election_results_per_group(3);
CALL calculate_election_results_per_group(4);

select * from ElectionResultsPerGroup;


CALL calculate_final_election_results(1);
CALL calculate_final_election_results(2);
CALL calculate_final_election_results(3);
CALL calculate_final_election_results(4);

SELECT * FROM ElectionResults;

