BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "users" (
	"id"	INTEGER NOT NULL,
	"email"	INTEGER NOT NULL,
	"password"	TEXT,
	"first_name"	TEXT,
	"surname"	TEXT,
	"age"	INTEGER,
	"gender"	TEXT,
	"contact_number"	TEXT,
	"user_type"	TEXT NOT NULL,
	"job_deg_cosmetic_name"	TEXT,
	"deg_id"	INTEGER,
	"profile_text"	TEXT,
	"course_year"	INTEGER,
	"paired_id"	INTEGER,
	"major_interest"	TEXT,
	"interest1"	INTEGER,
	"interest2"	INTEGER,
	"interest3"	INTEGER,
	"interest4"	INTEGER,
	"interest5"	INTEGER,
	"interest6"	INTEGER,
	"interest7"	INTEGER,
	"interest8"	INTEGER,
	"interest9"	INTEGER,
	"interest10"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "courses" (
	"deg_id"	INTEGER NOT NULL,
	"faculty1"	TEXT NOT NULL,
	"faculty2"	TEXT,
	"deg_name_functional"	INTEGER NOT NULL,
	PRIMARY KEY("deg_id" AUTOINCREMENT),
	FOREIGN KEY("deg_id") REFERENCES "users"("deg_id")
);
COMMIT;
