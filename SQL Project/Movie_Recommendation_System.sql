-- Movie Recommendation & Rating Analysis System
-- Mini project to practice SQL joins, aggregations and subqueries
-- SECTION 1: Creating the tables
-- basic user info
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    city VARCHAR(100)
);
-- movie details
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255),
    genre VARCHAR(100),
    language VARCHAR(50)
);
-- one row = one user rating one movie, scale of 1 to 5
CREATE TABLE Ratings (
    user_id INT,
    movie_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);
-- keeps track of when a user watched a movie
CREATE TABLE Watch_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    watch_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);
-- SECTION 2: Sample Data
-- users from different cities across India
INSERT INTO Users (user_id, name, age, city) VALUES
(1, 'Aarav Mehta', 23, 'Mumbai'),
(2, 'Priya Nair', 31, 'Kochi'),
(3, 'Rohit Sharma', 26, 'Delhi'),
(4, 'Sneha Iyer', 28, 'Bengaluru'),
(5, 'Karthik Reddy', 35, 'Hyderabad');
-- mix of Hindi, Telugu and Malayalam films
INSERT INTO Movies (movie_id, title, genre, language) VALUES
(101, 'Kalki 2898-AD', 'Sci-Fi', 'Telugu'),
(102, 'Animal', 'Action', 'Hindi'),
(103, 'RRR', 'Action', 'Telugu'),
(104, 'Jawan', 'Thriller', 'Hindi'),
(105, 'Manjummel Boys', 'Adventure', 'Malayalam'),
(106, '12th Fail', 'Drama', 'Hindi');
-- not everyone rates every movie, keeping it realistic
INSERT INTO Ratings (user_id, movie_id, rating) VALUES
(1, 101, 5), (1, 103, 4), (1, 106, 4),
(2, 103, 5), (2, 105, 5), (2, 104, 4),
(3, 101, 4), (3, 102, 5), (3, 103, 4),
(4, 104, 5), (4, 105, 4), (4, 106, 5),
(5, 102, 4), (5, 101, 5), (5, 106, 3);
-- watch dates from late 2025 to early 2026
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES
(1, 101, '2025-11-03'), (1, 103, '2025-11-18'), (1, 106, '2025-12-05'),
(2, 103, '2025-11-10'), (2, 105, '2025-12-01'), (2, 104, '2026-01-07'),
(3, 101, '2025-11-22'), (3, 102, '2025-12-14'),
(4, 104, '2025-12-09'), (4, 105, '2025-12-28'), (4, 106, '2026-01-15'),
(5, 102, '2025-11-05'), (5, 101, '2026-01-20');
-- SECTION 3: Queries
-- A) top rated movies (avg rating 4 or above)
SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
HAVING avg_rating >= 4.0
ORDER BY avg_rating DESC;
-- B) which genres are watched the most
SELECT m.genre, COUNT(w.history_id) AS total_watches
FROM Movies m
JOIN Watch_History w ON m.movie_id = w.movie_id
GROUP BY m.genre
ORDER BY total_watches DESC;
-- C) trending movies - watched after Dec 2025
SELECT m.title, COUNT(w.history_id) AS watch_count
FROM Movies m
JOIN Watch_History w ON m.movie_id = w.movie_id
WHERE w.watch_date > '2025-12-01'
GROUP BY m.title
ORDER BY watch_count DESC;
-- D) user activity - how many movies rated and their average score
SELECT u.name, COUNT(r.movie_id) AS total_rated, AVG(r.rating) AS avg_given
FROM Users u
LEFT JOIN Ratings r ON u.user_id = r.user_id
GROUP BY u.name;
-- E) recommendation for Aarav (user 1)
-- idea: suggest movies he hasn't seen yet, but liked by users who share similar taste
SELECT DISTINCT m.title
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
WHERE r.rating >= 4
AND m.movie_id NOT IN (SELECT movie_id FROM Watch_History WHERE user_id = 1)
AND r.user_id IN (
    SELECT user_id FROM Ratings
    WHERE movie_id IN (SELECT movie_id FROM Ratings WHERE user_id = 1 AND rating >= 4)
    AND user_id != 1
);