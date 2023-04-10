CREATE TABLE AdminUser (
    admin_id VARCHAR(255) PRIMARY KEY,
    admin_lastname VARCHAR(100),
	admin_firstname VARCHAR(100),
	admin_phonenumber VARCHAR(100),
	admin_address VARCHAR(100),
);
CREATE TABLE AdminUserInfo (
    admin_id VARCHAR(255),
    admin_username VARCHAR(100),
	admin_password VARCHAR(100),
	FOREIGN KEY (admin_id) REFERENCES AdminUser (admin_id)
);
CREATE TABLE Voter (
    voter_id INT PRIMARY KEY,
    voter_firstname VARCHAR(100),
	voter_lastname VARCHAR(100),
	voter_phonenumber VARCHAR(100),
	voter_address VARCHAR(100),
);
CREATE TABLE VoterUserInfo (
    user_id INT,
    user_username VARCHAR(100),
    user_password VARCHAR(100),
	user_vote_choice VARCHAR(100),
	FOREIGN KEY (user_id) REFERENCES Voter (voter_id)
);
CREATE TABLE Candidate (
    candidate_id INT PRIMARY KEY,
    candidate_lastname VARCHAR(100),
	candidate_firstname VARCHAR(100),
    voting_record INT
);
CREATE TABLE UsersWhoVoted (
    voted_id INT,
    voted_choice int,
	FOREIGN KEY (voted_id) REFERENCES Voter (voter_id),
	FOREIGN KEY (voted_choice) REFERENCES Candidate (candidate_id)
);



/* Insert values into the tables*/



INSERT INTO AdminUser (admin_id, admin_lastname, admin_firstname, admin_phonenumber, admin_address)
VALUES ('admin1', 'Doe', 'John', '1234567890', '1234 Elm Street'),
       ('admin2', 'Smith', 'Jane', '9876543210', '5678 Oak Avenue');

INSERT INTO AdminUserInfo (admin_id, admin_username, admin_password)
VALUES ('admin1', 'johndoe', 'password1'),
       ('admin2', 'janesmith', 'password2');

INSERT INTO Voter (voter_id, voter_firstname, voter_lastname, voter_phonenumber, voter_address)
VALUES (1, 'Alice', 'Johnson', '9022214531', '7890 Maple Lane'),
       (2, 'Bob', 'Williams', '9020841521', '5678 Birch Avenue'),
       (3, 'Charlie', 'Brown', '9023316664', '1234 Cedar Street');

INSERT INTO VoterUserInfo (user_id, user_username, user_password, user_vote_choice)
VALUES (1, 'alicej', 'password1', 1),
       (2, 'bobw', 'password2', 2),
       (3, 'charlieb', 'password3', 2);

INSERT INTO Candidate (candidate_id, candidate_lastname, candidate_firstname, voting_record)
VALUES (1, 'Smith', 'John', 1),
       (2, 'Johnson', 'Jane', 2);

INSERT INTO UsersWhoVoted (voted_id, voted_choice)
VALUES (1, 1),
       (2, 2),
       (3, 2);


BEGIN TRANSACTION
/*Update the login credentials for valid user*/
USE [PollingSystem];  
GO
UPDATE VoterUserInfo
SET user_username = 'TestUsername', user_password = 'TestPassword'
WHERE user_id = 1;
GO

/*Delete specific user from the database*/
USE [PollingSystem];  
GO
DELETE FROM Voter
WHERE voter_id = 2;
DELETE FROM VoterUserInfo
WHERE user_id = 2;
DELETE FROM UsersWhoVoted
WHERE voted_id = 2;
GO

/*To clear all the data records without deleting the schema (database design)*/
/*
USE [PollingSystem];
GO
DELETE FROM AdminUser;
DELETE FROM AdminUserInfo;
DELETE FROM Candidate;
DELETE FROM UsersWhoVoted;
DELETE FROM Voter
DELETE FROM VoterUserInfo
GO
*/

/*Candidates with the top 2 highest voting record*/
SELECT TOP 2 candidate_id, candidate_lastname, candidate_firstname, voting_record
FROM Candidate
ORDER BY voting_record DESC;

/*Candidate with the least voting record:*/
SELECT TOP 1 candidate_id, candidate_lastname, candidate_firstname, voting_record
FROM Candidate
ORDER BY voting_record ASC;

/*Candidate who got votes between 5 to 15*/
SELECT candidate_id, candidate_lastname, candidate_firstname, voting_record
FROM Candidate
WHERE voting_record BETWEEN 0 AND 2;

/*Voting record for each registered candidate*/
SELECT TOP 2 candidate_id, candidate_lastname, candidate_firstname, voting_record
FROM Candidate

/*Winner candidate name*/
SELECT TOP 1 candidate_lastname, candidate_firstname
FROM Candidate
ORDER BY voting_record DESC;
COMMIT TRANSACTION