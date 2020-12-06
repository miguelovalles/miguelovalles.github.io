/* Miguel Ovalles Final Project SQL */

/* Building new database outside of codio */
/* Databases were previously created in Codio, needed to recreate them */

CREATE TABLE person ( 
    person_id INT(8) UNSIGNED NOT NULL auto_increment,
    first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (person_id)
) AUTO_INCREMENT=1;

CREATE TABLE contact_list ( 
    connection_id INT(8) UNSIGNED NOT NULL auto_increment,
    person_id INT(8) NOT NULL,
	contact_id INT(8) NOT NULL,
    PRIMARY KEY (connection_id)
) AUTO_INCREMENT=1;

CREATE TABLE message ( 
    message_id INT(8) UNSIGNED NOT NULL auto_increment,
    sender_id INT(8) NOT NULL,
	receiver_id INT(8) NOT NULL,
	message VARCHAR(255) NOT NULL,
	send_datetime datetime,
    PRIMARY KEY (message_id)
) AUTO_INCREMENT=1;

/* Selecting the database */

USE messaging;

/* Viewing existing tables and columns */

SHOW TABLES FROM messaging;

SHOW COLUMNS FROM person;

SHOW COLUMNS FROM contact_list;

SHOW COLUMNS FROM message;


/* Task 1 */ 

/* Updated insert sql to include additional values and location in one program */

SELECT * FROM person;

INSERT INTO 
	messaging.person (first_name, last_name, location) 
VALUES
	("Sophia", "Ovalles", "New Jersey"),
	("Hannah", "Ovalles", "New Jersey"),
	("Diana", "Taurasi", "New York"),
	("Michael", "Jordan", "New Orleans")
;

/* Task 2 */

SELECT * FROM

ALTER TABLE 
	messaging.person 
ADD 
	location VARCHAR(125) NOT NULL;

SHOW COLUMNS FROM messaging.person;


/* Task 3 */

SELECT * FROM messaging.person;   

UPDATE 
	messaging.person 
SET 
	location = 'New York' 
WHERE 
	person.first_name = "Miguel"
AND 
	person.last_name = "Ovalles";

/* Task 3 update change where to primary key for efficiency, need to get id assigned to user */	

UPDATE 
	messaging.person 
SET 
	location = 'New York' 
WHERE 
    person.person_id = 1;



/* Task 4 */

SELECT * FROM messaging.person;


DELETE FROM
	messaging.person
WHERE
	person.first_name = "Diana"
AND 
	person.last_name = "Taurasi"
;

/* Task 4 update to delete user entry by id instead of multiple variables */ 

/* Different variations can be used for this process, use first name only, last name, id or even where not equal to a specific variable */

DELETE FROM
	messaging.person
WHERE
	person_id = 3;
	
	

/* Task 5 */

SHOW COLUMNS FROM messaging.contact_list;

ALTER TABLE 
	messaging.contact_list 
ADD 
	favorite VARCHAR(10) DEFAULT NULL
;
		
		
/* Task 6 */

SELECT * FROM messaging.contact_list;

UPDATE
	messaging.contact_list
SET
	favorite = "y"
WHERE 
	contact_list.contact_id = 1
;

/* Task 7 */

SELECT * FROM messaging.contact_list;

UPDATE
	messaging.contact_list
SET
	favorite = "n"
WHERE 
	contact_list.contact_id <> 1
;

/* Task 8 */

SELECT * FROM messaging.person; /* Get Miguel Ovalles person_id */

INSERT INTO	
	messaging.contact_list (person_id, contact_id, favorite)
VALUES
	(7, 1, "n"),
	(1, 7, "y"),
	(7, 5, "y")
;

SELECT * FROM messaging.contact_list;

/*Task 8 advanced query bulk insert create a csv file with the columns and data*/

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\contact_list.csv'

INTO TABLE CONTACT_LIST

FIELDS TERMINATED BY ','

ENCLOSED BY '"'

LINES TERMINATED BY '/n'

IGNORE 1 ROWS;


/* Task 9 */

SHOW TABLES;

CREATE TABLE 
	image ( 
    image_id INT(8) NOT NULL auto_increment,
    image_name VARCHAR(50) NOT NULL,
	image_location VARCHAR(250) NOT NULL,
    PRIMARY KEY (image_id)
) AUTO_INCREMENT=1
;

SHOW COLUMNS FROM image;

/* Task 10 */

SHOW TABLES;

CREATE TABLE 
	message_image ( 
    message_id INT(8) NOT NULL,
    image_id INT(8) NOT NULL,
PRIMARY KEY (message_id, image_id),
FOREIGN KEY (image_id) REFERENCES image(image_id)	
);

SHOW COLUMNS FROM message_image;

/* Task 11 */

SELECT * FROM messaging.image;

INSERT INTO
	messaging.image (image_name, image_location)
VALUES
	("kids1", "Home"),
	("kids2", "Park"),
	("kids3", "Park"),
	("kids4", "Park"),
	("kids5", "Home")
;

/* Task 12 */

SELECT * FROM messaging.message_image;

INSERT INTO
	messaging.message_image (message_id, image_id)
VALUES
	(1, 1),
	(1, 5),
	(2, 2),
	(2, 3),
	(3, 4)
;
	
/* Task 13 */

SELECT 
	SND.first_name AS "Sender First Name",
	SND.last_name AS "Sender Last Name", 
	RCV.first_name AS "Receiver First Name", 
	RCV.last_name AS "Receiver Last Name", 
	MSG.message_id AS "Message ID", 
	MSG.message AS "Message",
	MSG.send_datetime AS "Message Timestamp"
FROM 
	person SND, 
	person RCV, 
	message MSG
WHERE 
	SND.person_id  = MSG.sender_id
AND 
	RCV.person_id = MSG.receiver_id
AND 
	SND.first_name = "Michael"
AND 
	SND.last_name = "Phelps";

/* Task 14 */

SELECT 
	COUNT(*) AS "Count of Messages",
	SND.person_ID AS "Person ID",
	SND.first_name AS "Sender First Name",
	SND.last_name AS "Sender Last Name"
FROM 
	person SND, message MSG
WHERE 
	SND.person_id = MSG.sender_id
GROUP BY 
	SND.person_id;

/* Task 15 */

SELECT
	MSGI.message_id AS "Message ID", 
	MIN(MSG.message) AS "Message",
	MIN(MSG.send_datetime) AS "Message Timestamp",
	MIN(IMG.image_name) AS "Image Name",
	MIN(IMG.image_location) AS "Image Location"
FROM
	message MSG 
INNER JOIN 
	message_image MSGI 
ON
	MSG.message_id = MSGI.message_id 
INNER JOIN
	image IMG 
ON
	IMG.image_id = MSGI.image_id
GROUP BY MSGI.message_id;

Miguel_Ovalles_Final_Project_SQL W Updates.txt
Displaying Miguel_Ovalles_Final_Project_SQL W Updates.txt.
