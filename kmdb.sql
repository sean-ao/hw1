-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy.
-- - Movie data includes the movie title, year released, MPAA rating,
--   and studio.
-- - There are many studios, and each studio produces many movies, but
--   a movie belongs to a single studio.
-- - An actor can be in multiple movies.
-- - Everything you need to do in this assignment is marked with TODO!

-- User stories
--
-- - As a guest, I want to see a list of movies with the title, year released,
--   MPAA rating, and studio information.
-- - As a guest, I want to see the movies which a single studio has produced.
-- - As a guest, I want to see each movie's cast including each actor's
--   name and the name of the character they portray.
-- - As a guest, I want to see the movies which a single actor has acted in.
-- * Note: The "guest" user role represents the experience prior to logging-in
--   to an app and typically does not have a corresponding database table.


-- Deliverables
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
-- - Insertion of "Batman" sample data into tables.
-- - Selection of data, so that something similar to the sample "report"
--   below can be achieved.

-- Rubric
--
-- 1. Domain model - 6 points
-- - Think about how the domain model needs to reflect the
--   "real world" entities and the relationships with each other. 
--   Hint: It's not just a single table that contains everything in the 
--   expected output. There are multiple real world entities and
--   relationships including at least one many-to-many relationship.
-- 2. Execution of the domain model (CREATE TABLE) - 4 points
-- - Follow best practices for table and column names
-- - Use correct data column types (i.e. TEXT/INTEGER)
-- - Use of the `model_id` naming convention for foreign key columns
-- 3. Insertion of data (INSERT statements) - 4 points
-- - Insert data into all the tables you've created
-- - It actually works, i.e. proper INSERT syntax
-- 4. "The report" (SELECT statements) - 6 points
-- - Write 2 `SELECT` statements to produce something similar to the
--   sample output below - 1 for movies and 1 for cast. You will need
--   to read data from multiple tables in each `SELECT` statement.
--   Formatting does not matter.

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
DROP TABLE IF EXISTS release_dates;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS studios;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS character_names;

-- Create new tables, according to your domain model
CREATE TABLE release_dates (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  movie_name TEXT,
  movie_date INTEGER
);

CREATE TABLE ratings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  release_date_id INTEGER,
  mpaa TEXT,
);

CREATE TABLE studios (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  release_date_id INTEGER,
  studio_name TEXT
);

CREATE TABLE actors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  release_date_id INTEGER,
  actor_name TEXT,
);

CREATE TABLE character_names (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  release_date_id INTEGER,
  character TEXT
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
INSERT INTO release_dates (movie_name, movie_date)
VALUES ('Batman Begins', 2005)
VALUES ('The Dark Knight Rises', 2008)
VALUES ('The Dark Knight Rises', 2012)
;

INSERT INTO ratings (mpaa)
VALUES ('PG-13')
VALUES ('PG-13')
VALUES ('PG-13')
;

INSERT INTO studios (studio_name)
VALUES ('Warner Bros.')
VALUES ('Warner Bros.')
VALUES ('Warner Bros.')
;

INSERT INTO actors (actor_name)
VALUES ('Christian Bale')
VALUES ('Michael Caine')
VALUES ('Liam Neeson')
VALUES ('Katie Holmes')
VALUES ('Gary Oldman')
VALUES ('Heath Ledger')
VALUES ('Aaron Eckhart')
VALUES ('Maggie Gyllenhaal')
VALUES ('Tom Hardy')
VALUES ('Joseph Gordon-Levitt')
VALUES ('Anne Hathaway')
;

INSERT INTO character_names (character)
VALUES ('Bruce Wayne')
VALUES ('Alfred')
VALUES ('Ra's Al Ghul')
VALUES ('Rachel Dawes')
VALUES ('Commissioner Gordon')
VALUES ('Joker')
VALUES ('Harvey Dent')
VALUES ('Rachel Dawes')
VALUES ('Bane')
VALUES ('John Blake')
VALUES ('Selina Kyle')
;

-- Prints a header for the movies output
.print "Movies"
.print "Title"
.print "Year"
.print "Rating"
.print "Studio"

-- The SQL statement for the movies output
SELECT release_dates.movie_name, release_dates.movie_date, ratings.mpaa, studios.studio_name
FROM release_dates
INNER JOIN ratings ON release_dates.movie_name = ratings.release_date_id
INNER JOIN studios ON release_dates.movie_name = studios.release_date_id
;

-- Prints a header for the cast output
.print "Top Cast"
.print "Title"
.print "Actor"
.print "Character"


-- The SQL statement for the cast output
SELECT release_dates.movie_name, actors.actor_name, character_names.character
FROM release_dates
INNER JOIN actors ON release_dates.movie_name = actors.release_date_id
INNER JOIN character_names ON release_dates.movie_name = character_names.release_date_id
;
