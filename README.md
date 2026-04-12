# Virtusa Mini Projects

A small collection of mini projects built during my Virtusa training. Each project covers a different language and concept — Python, Java, and SQL — with a focus on writing clean, practical code from scratch.

---

## What's Inside

### 🐍 Python — OPS-Bot (Security Log Analyzer)

**Files:** `OPS-Bot.py`, `generate-log.py`

OPS-Bot is a lightweight command-line tool that scans a server log file and pulls out anything suspicious — errors, critical events, and failed login attempts. I also wrote a separate script (`generate-log.py`) to produce a realistic 5,000-line log so the bot has something to work with.

**How it works:**
1. `generate-log.py` creates a `server.log` with randomized but realistic entries (INFO, ERROR, CRITICAL, FAILED LOGIN)
2. `OPS-Bot.py` reads that log, counts each type of alert, and saves a dated report — `security_alert_YYYY-MM-DD.txt`

**Run it:**
```bash
# Step 1 — generate the log
python3 generate-log.py

# Step 2 — run the analyzer
python3 OPS-Bot.py
```

**Sample output:**
```
OpsBot starting...
Reading: server.log

--- Scan Complete ---
Total suspicious lines found: 742

Breakdown by type:
  ERROR: 398
  CRITICAL: 199
  FAILED LOGIN: 145

Writing report to: security_alert_2026-04-12.txt
Report file size: 53810 bytes

OpsBot done. Check the alert file for details.
```

---

### ☕ Java — Password Validator

**File:** `PasswordValidator.java`

A console program that enforces a basic password policy for an employee portal. It keeps prompting the user until they enter a password that meets all the rules, and it tells them exactly what's wrong each time they fail.

**Policy:**
- At least 8 characters
- At least one uppercase letter
- At least one digit (0–9)

**Run it:**
```bash
javac PasswordValidator.java
java PasswordValidator
```

**Sample interaction:**
```
============================================
   SafeLog Employee Portal — Password Setup
============================================
Policy: min 8 chars | 1 uppercase | 1 digit

Enter a new password: hello

[REJECTED] Password does not meet policy requirements:
  - Too short (minimum 8 characters, yours has 5)
  - Missing an uppercase letter
  - Missing a digit (0-9)
Please try again.

Enter a new password: Secure99

[OK] Password accepted! Your account is now secured.
```

---

### 🗃️ SQL — Movie Recommendation & Rating System

**File:** `Movie_Recommendation_System.sql`

A SQL mini-project that models a simple movie platform — users, movies, ratings, and watch history. Written for SQLite, it demonstrates joins, aggregations, subqueries, and a basic collaborative-filtering recommendation query.

**Schema:**

| Table | Purpose |
|---|---|
| `Users` | Stores user profiles (name, age, city) |
| `Movies` | Movie catalog with genre and language |
| `Ratings` | Each user's rating for a movie (1–5 scale) |
| `Watch_History` | Tracks when a user watched a movie |

**Queries included:**
- **Top-rated movies** — films with an average rating of 4.0 or above
- **Most-watched genres** — ranked by total watch count
- **Trending movies** — watched after December 2025
- **User activity** — how many movies each user has rated and their average score
- **Personalized recommendations** — suggests movies a user hasn't seen yet, based on what similar users liked

**Run it in SQLite:**
```bash
sqlite3 movies.db < Movie_Recommendation_System.sql
```

---

## Stack

| Project | Language | Concepts Covered |
|---|---|---|
| OPS-Bot | Python 3 | File I/O, string parsing, dictionaries, `os`, `datetime` |
| Password Validator | Java | Loops, string methods, Scanner, input validation |
| Movie System | SQL (SQLite) | Joins, GROUP BY, HAVING, subqueries, foreign keys |

---

## Notes

- The `server.log` and generated alert files are excluded from this repo (they're outputs, not source code).
- All sample data in the SQL project uses Indian names, cities, and recent Bollywood/Tollywood/Mollywood films to keep it contextual.
