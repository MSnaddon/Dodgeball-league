DROP TABLE matches;
DROP TABLE teams;

CREATE TABLE teams (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);
CREATE TABLE matches (
  id SERIAL4 PRIMARY KEY,
  home_team_id INT4 REFERENCES  teams(id) ON DELETE CASCADE,
  away_team_id  INT4 REFERENCES teams(id) ON DELETE CASCADE,
  home_team_score INT2,
  away_team_score INT2
);

INSERT INTO teams (name) VALUES ('Duck');
INSERT INTO teams (name) VALUES ('Dive');
INSERT INTO teams (name) VALUES ('Dodge');
INSERT INTO teams (name) VALUES ('Dip');
INSERT INTO teams (name) VALUES ('Doge');

INSERT INTO matches (home_team_id, away_team_id, home_team_score, away_team_score) VALUES (1,2,0,2);
INSERT INTO matches (home_team_id, away_team_id, home_team_score, away_team_score) VALUES (1,3,4,4);
INSERT INTO matches (home_team_id, away_team_id, home_team_score, away_team_score) VALUES (2,3,1,0);
INSERT INTO matches (home_team_id, away_team_id, home_team_score, away_team_score) VALUES (1,4,3,0);
INSERT INTO matches (home_team_id, away_team_id, home_team_score, away_team_score) VALUES (2,4,3,4);
INSERT INTO matches (home_team_id, away_team_id, home_team_score, away_team_score) VALUES (3,4,2,2);


