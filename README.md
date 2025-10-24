# Voting System

![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)

A secure and scalable MySQL-based voting system that supports multiple election types, encrypted vote storage, and flexible vote counting methods. Perfect for organizations, universities, or any entity needing a robust electronic voting solution.

## Features

### Vote Counting Methods
- **Popular Vote**
  - Counts all votes from all districts
  - Ranks candidates by total vote count
  - Suitable for direct elections
  
- **Electoral College**
  - Districts have weighted scores (electoral votes)
  - District winner takes all electoral votes
  - Models electoral systems like US presidential elections

### Election Types
- **Single Choice**: Traditional one-person-one-vote
- **Multi Choice**: Select multiple winners (e.g., board elections)
- **Referendum**: Yes/No voting with support for both counting methods

### Security Features
- AES encryption for stored votes
- Hashed user IDs in vote records
- Geographic validation of voter eligibility

## Project Structure
- `main.sql` — entry script that creates the database and sources the other scripts (schemas, indexes, inserts, tests, procedures).
- `UserSchema.sql` — geographic tables, `Users`, and address mapping (`locates`).
- `ElectionSchema.sql` — election-related tables: `Elections`, `ElectionGroups`, `GroupDistricts`, `Candidates`, `VoteDetails`, `encrypted_candidates`, `ElectionResultsPerGroup`, `ElectionResults`.
- `ElectionResultsProcedures.sql` — stored procedures that decrypt and aggregate votes per group and compute final results.
- `get_procedures.sql` — helper procedures to retrieve results and map users to groups.
- `Indexing.sql` — (expected) index creation to optimize queries (sourced by `main.sql`).
- `InsertingUsers.sql`, `InsertingCountries.sql` — sample data loaders.
- `Test*.sql` — test scenarios for popular, electoral and referendum elections.
- `test.sql` — additional test script.

There is also a `countries/egypt.csv` file used by the insert scripts.

## Database schema overview (high level)

Tables (short descriptions and important columns):

- `Elections`
  - id, election_name, start_date, end_date, description
  - vote_count_method ENUM('ELECTORAL_COLLEGE','POPULAR_VOTE')
  - type_name ENUM('ONE_CHOICE','MULTI_CHOICE','REFERENDUM')
  - max_choices INT — controls how many winners may be selected
  - created_by -> `Users(id)`

- `ElectionGroups`
  - id, election_id -> `Elections(id)`, group_name, score (number of seats)
  - groups partition the electorate for the electoral-college mode

- `GroupDistricts`
  - mapping of `group_id` to `district_id` within an `election_id` (used to assign voters by district)

- `Candidates`
  - id, user_id (nullable for referendum options), election_id
  - is_referendum_option BOOLEAN, option_label (e.g. 'Yes'/'No')

- `VoteDetails`
  - id, hashed_user_id, group_id, timestamp — tracks a cast vote's metadata

- `encrypted_candidates`
  - id, vote_id -> `VoteDetails(id)`, encrypted_candidate (base64), iv
  - stores the (AES) encrypted candidate choice per vote for privacy

- `ElectionResultsPerGroup`
  - per-group aggregate of `candidate_id`, `vote_count`, `percentage`

- `ElectionResults`
  - per-election aggregate of `candidate_id`, total `vote_count`, `percentage`, `is_winner`

- Geographic and user tables (from `UserSchema.sql`): `Countries`, `States_Governorates`, `Cities`, `Districts`, `Users`, `locates`.
  - `locates` connects `Users` to `Districts` and stores `national_id`.

## Important stored procedures

- `p_EncryptData` / `p_DecryptData` — small examples showing AES encrypt/decrypt (MySQL AES_ENCRYPT/AES_DECRYPT) using a passphrase-derived key.

- `p_calculate_election_results_per_group(p_election_id, key_str)`
  - Decrypts encrypted candidate values per vote using the provided key.
  - Aggregates vote counts per `ElectionGroups` and populates `ElectionResultsPerGroup` (vote_count, percentage).
  - This procedure expects the encryption key (or passphrase) to decrypt stored `encrypted_candidate` values.

- `p_calculate_final_election_results(p_election_id)`
  - Reads `Elections.vote_count_method` and `Elections.max_choices` to decide how to compute final results.
  - If `POPULAR_VOTE`: sums votes across groups for each candidate and writes `ElectionResults`.
  - Else (Electoral College): for each group, the candidate with the highest votes in the group wins that group's `score` seats; sums seats per candidate and writes `ElectionResults`.
  - Uses a ranking and then marks `is_winner` for the top `max_choices` entries.

- `p_get_election_results(p_election_id)`
  - Returns a readable list of candidates, counts, percentages and winner flags for the election. For referendums it shows option labels instead of user names.

- `p_get_user_group_id(u_id, elec_id, OUT group_id)`
  - Maps a user to their group for a given election by joining `locates`, `Districts` and `GroupDistricts`.

## Constraints and behaviors to note

- `Candidates` enforces either a `user_id` (normal candidate) or `is_referendum_option = TRUE` with `option_label` (referendum option).
- `Elections` contains checks ensuring `max_choices` and `type_name` are consistent. For example, referendums and one-choice elections should have `max_choices = 1`.
- `VoteDetails` and `encrypted_candidates` are used to store votes with encrypted candidate references. The procedures rely on a consistent encryption key to decrypt values.

## How to run (quick start)

Prerequisites:
- MySQL (5.7+ or 8.x recommended) installed and running.
- A MySQL user with privileges to create databases and objects.

1. Clone the repository:
   ```bash
   git clone https://github.com/mohamed20o03/Voting_system.git
   cd Voting_system
   ```

2. Create the database and tables:
   ```bash
   mysql -u root -p < main.sql
   ```

3. The script will:
   - Create the `voting_system` database
   - Set up all tables and procedures
   - Import sample data
   - Run test scenarios

### Running an Election

1. Set up the election:
   ```sql
   INSERT INTO Elections (
       election_name, start_date, end_date, 
       vote_count_method, type_name, max_choices
   ) VALUES (
       'Presidential Election 2024',
       '2024-11-03 00:00:00', '2024-11-03 23:59:59',
       'ELECTORAL_COLLEGE', 'ONE_CHOICE', 1
   );
   ```

2. Calculate results:
   ```sql
   -- Aggregate votes per district
   CALL p_calculate_election_results_per_group(@election_id, @encryption_key);
   
   -- Calculate final results
   CALL p_calculate_final_election_results(@election_id);
   
   -- View results
   CALL p_get_election_results(@election_id);
   ```

## Security Notes

### Vote Encryption
- Uses MySQL's AES_ENCRYPT/AES_DECRYPT
- Keys derived from passphrase using SHA2
- Initialization vectors (IV) stored per vote
- Candidate choices stored encrypted
- User IDs hashed in vote records

### Best Practices
- Never commit encryption keys
- Store encryption keys securely
- Rotate keys periodically
- Monitor access logs
- Regular security audits

## Testing

The repository includes test scenarios:
- `TestPopularOneChoice.sql`: Single-winner popular vote
- `TestPopularMultiChoise.sql`: Multi-winner scenarios
- `TestElectoral.sql`: Electoral college simulations
- `TestReferendum.sql`: Yes/No voting examples

## Documentation

### Important Files
- `docs/`: Technical documentation
- `schema/`: Database diagrams
- `examples/`: Sample queries
- `tests/`: Test scenarios

### API Documentation
- Stored procedures
- Triggers
- Views
- Encryption functions

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

