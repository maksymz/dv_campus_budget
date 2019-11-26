DROP DATABASE IF EXISTS budget;

CREATE DATABASE budget;

CREATE USER 'budget'@'%' IDENTIFIED BY 'q1w2e3r4';

GRANT ALL ON budget.* TO 'budget'@'%';


# Creating tables
CREATE TABLE user (
  user_name varchar(127) NOT NULL COMMENT 'User Name',
  email varchar(127) NOT NULL COMMENT 'Email',
  login varchar(127) NOT NULL COMMENT 'Login',
  dob DATE DEFAULT NULL COMMENT 'Date of Birth'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users';

CREATE TABLE user_group (
    user_group_name varchar(127) NOT NULL COMMENT 'User Group Name'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User Groups';

CREATE TABLE purchased_item (
    purchased_item varchar(127) NOT NULL COMMENT 'Purchased Item',
    price decimal(20, 6) NOT NULL COMMENT 'Purchased Item Price',
    purchased_at DATETIME NOT NULL COMMENT 'Purchased As'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Purchased Items';

CREATE TABLE category (
    category_name varchar(127) NOT NULL COMMENT 'Category'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Categories';

CREATE TABLE tag (
    tag varchar(127) NOT NULL COMMENT 'Tags'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tags';


# Alter table
ALTER TABLE user
    ADD COLUMN password CHAR(40) NOT NULL COMMENT 'Password' AFTER login;

# Add primary keys
ALTER TABLE user
    ADD COLUMN user_id INT(10) UNSIGNED NOT NULL
        AUTO_INCREMENT PRIMARY KEY COMMENT 'User ID' FIRST;

ALTER TABLE user_group
    ADD COLUMN user_group_id INT(10) UNSIGNED NOT NULL
        AUTO_INCREMENT PRIMARY KEY COMMENT 'User Group ID' FIRST;

ALTER TABLE purchased_item
    ADD COLUMN purchased_item_id BIGINT(20) UNSIGNED NOT NULL
        AUTO_INCREMENT PRIMARY KEY COMMENT 'Purchased Item ID' FIRST;

ALTER TABLE category
    ADD COLUMN category_id INT(10) UNSIGNED NOT NULL
        AUTO_INCREMENT PRIMARY KEY COMMENT 'Category ID' FIRST;

ALTER TABLE tag
    ADD COLUMN tag_id INT(10) UNSIGNED NOT NULL
        AUTO_INCREMENT PRIMARY KEY COMMENT 'Tag ID' FIRST;


# Add future foreign keys
ALTER TABLE user
    ADD COLUMN user_group_id INT(10) UNSIGNED DEFAULT NULL
        COMMENT 'User Group ID' AFTER user_id;

ALTER TABLE purchased_item
    ADD COLUMN user_id INT(10) UNSIGNED NOT NULL
        COMMENT 'User ID' AFTER purchased_item_id,
    ADD COLUMN category_id INT(10) UNSIGNED NOT NULL
        COMMENT 'Category ID' AFTER user_id;

CREATE TABLE purchased_item_tag (
    purchased_item_id BIGINT(20) UNSIGNED NOT NULL,
    tag_id INT(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Purchased Item Tags';

ALTER TABLE user
    ADD CONSTRAINT USER_USER_ID_USER_GROUP_USER_GROUP_ID
        FOREIGN KEY (user_group_id) REFERENCES user_group (user_group_id)
            ON DELETE SET NULL;

ALTER TABLE purchased_item
    ADD CONSTRAINT PURCHASED_ITEM_USER_ID_USER_USER_ID
        FOREIGN KEY (user_id) REFERENCES user (user_id)
            ON DELETE CASCADE,
    ADD CONSTRAINT PURCHASED_ITEM_CATEGORY_ID_CATEGORY_CATEGORY_ID
        FOREIGN KEY (category_id) REFERENCES category (category_id)
            ON DELETE RESTRICT;

ALTER TABLE purchased_item_tag
    ADD CONSTRAINT PURCHASED_ITEM_TAG_PIID_PURCHASED_ITEM_PURCHASED_ITEM_ID
        FOREIGN KEY (purchased_item_id) REFERENCES purchased_item (purchased_item_id)
            ON DELETE CASCADE,
    ADD CONSTRAINT PURCHASED_ITEM_TAG_TAG_ID_TAG_TAG_ID
        FOREIGN KEY (tag_id) REFERENCES tag (tag_id)
            ON DELETE CASCADE;


# Empty all tables and reset AUTO_INCREMENT
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE user_group;
TRUNCATE TABLE user;
TRUNCATE TABLE category;
TRUNCATE TABLE purchased_item;
TRUNCATE TABLE tag;
SET FOREIGN_KEY_CHECKS=1;

# Create a connection between users and their tags
ALTER TABLE tag
    ADD COLUMN user_id INT(10) UNSIGNED NOT NULL
        COMMENT 'User ID' AFTER tag,
    ADD CONSTRAINT TAG_USER_ID_USER_USER_ID
        FOREIGN KEY (user_id) REFERENCES user (user_id)
            ON DELETE cascade;


# Insert Data
INSERT INTO user_group (user_group_name) VALUES
('My family'),
('John Doe\'s Family'),
('Yet another family');

# Default date format is `Y-m-d` (year-month-date)
INSERT INTO user (user_group_id, user_name, email, login, `password`, dob) VALUES
(NULL, 'Maksym Zaporozhets', 'maksimz@default-value.com', 'maksymz', 'dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs', '1988-10-22'),
(2, 'John Doe', 'john-doe@example.com', 'john_doe', 'dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs', NULL),
(2, 'Jane Doe', 'jane-doe@example.com', 'jane_doe', 'dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs', NULL),
(3, 'James Smith', 'james_smith@example.com', 'james_smith', 'dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs', NULL),
(3, 'Emily Smith', 'emily_smith@example.com', 'emily_smith', 'dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs', NULL),
(NULL, 'Anonymous', 'anonymous@example.com', 'anonymous', 'dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs', NULL);


INSERT INTO tag (tag, user_id) VALUES
('Home', 1),
('Family', 1),
('Programming', 1),
('Ballroom', 1),
('Trips', 2),
('Home', 2),
('Bikes', 4),
('Party', 4),
('Rest', 4),
('Hacking equipment', 6),
('Hacking equipment', 6),
('Hacking equipment', 6);

INSERT INTO tag (tag, user_id) VALUES
('Trips', 3),
('Home', 3);

INSERT INTO category (category_name) VALUES
('Home'),
('Education'),
('Recreation'),
('Appliances'),
('Food'),
('Health');

INSERT INTO purchased_item (user_id, category_id, purchased_item, price, purchased_at) VALUES
# home - 1, family - 2, programming - 3
(1, 4, 'Microwave oven', 1999, '2019-11-10'),
(1, 5, 'Milk', 31.35, '2019-11-12'),
(1, 5, 'Coffee', 233, '2019-11-12'),
(1, 5, 'Fish', 142.35, '2019-11-13'),
(1, 2, 'Docker course', 1999, '2019-11-14'),
# trips - 5, home - 6
(2, 3, 'Yosemite national park', 7500, '2019-10-29'),
(2, 3, 'Weekend in Miami', 8000, '2019-11-12'),
(2, 3, 'New Year celebration', 5400, '2020-01-01'),
(3, 1, 'Garland', 350, '2019-11-13'),
(3, 1, 'Candles', 300, '2019-11-14'),
# bikes - 7, party - 8, rest - 9
(4, 3, 'New bike for me', 1999, '2019-11-10'),
(4, 3, 'New bike for Emily', 31.35, '2019-11-12'),
(4, 3, 'Crisps', 333, '2019-11-12'),
(4, 3, 'Beer', 230, '2019-11-12'),
# hacking equipment - 10
(6, 2, 'Virus - Petya', 230, '2018-11-12'),
(6, 2, 'Virus - Vasya', 230, '2018-11-12');

INSERT INTO purchased_item_tag (purchased_item_id, tag_id) VALUES
(1, 1), (2, 2), (3, 2), (4, 2), (5, 3),
(6, 5), (7, 5), (8, 5), (9, 6), (10, 6),
(11, 7), (12, 7), (13, 8), (14, 8), (13, 9), (14, 9),
(15, 10), (16, 10);

# SQL examples
SELECT purchased_item_id, purchased_item, price, purchased_at
FROM purchased_item;

SELECT * FROM user;

SELECT * FROM purchased_item WHERE price >= 1000;

SELECT * FROM user WHERE user_group_id IS NULL;

SELECT * FROM user WHERE user_group_id IN (2, 3);

SELECT * FROM purchased_item WHERE purchased_at BETWEEN '2019-11-01' AND '2019-11-30';

SELECT * FROM user WHERE user_name LIKE "%Smith%";

SELECT * FROM user WHERE user_name LIKE "%Smith";

SELECT * FROM user_group, user;

SELECT * FROM user_group, user WHERE user.user_group_id = user_group.user_group_id;

SELECT * FROM user_group AS ug CROSS JOIN user AS u;

SELECT * FROM user_group AS ug NATURAL LEFT JOIN user AS u;


SELECT * FROM user, purchased_item;

SELECT u.*
FROM user AS u
     INNER JOIN purchased_item AS pi ON u.user_id = pi.user_id;

SELECT u.*
FROM user AS u
     INNER JOIN purchased_item AS pi
        ON u.user_id = pi.user_id
        AND u.user_id = 1;

SELECT u.*
FROM user AS u
    INNER JOIN purchased_item AS pi
        ON u.user_id = pi.user_id
WHERE u.user_id = 1;

SELECT *
FROM user AS u
     LEFT JOIN purchased_item AS pi ON u.user_id = pi.user_id
WHERE pi.user_id IS NULL;

SELECT *
FROM user AS u
    NATURAL JOIN purchased_item AS p;

SELECT *
FROM user AS u
    CROSS JOIN purchased_item AS p;





SELECT DISTINCT ug.*, u.user_name, t.*
FROM user_group AS ug
     RIGHT JOIN user AS u
        ON ug.user_group_id = u.user_group_id
     INNER JOIN purchased_item AS pi
        ON u.user_id = pi.user_id
     INNER JOIN purchased_item_tag AS pit
        ON pi.purchased_item_id = pit.purchased_item_id
     INNER JOIN tag AS t
        ON pit.tag_id = t.tag_id;


SELECT DISTINCT ug.*, u.user_name, t.*
FROM user AS u
     LEFT JOIN user_group AS ug
       ON ug.user_group_id = u.user_group_id
     INNER JOIN purchased_item AS pi
        ON u.user_id = pi.user_id
     INNER JOIN purchased_item_tag AS pit
        ON pi.purchased_item_id = pit.purchased_item_id
     INNER JOIN tag AS t
        ON pit.tag_id = t.tag_id;


SELECT u.user_name, pi.*
FROM user AS u
     INNER JOIN purchased_item AS pi ON u.user_id = pi.user_id;

SELECT u.user_name,
   COUNT(pi.user_id) AS total_purchases,
   SUM(pi.price) AS total_spendings,
   AVG(pi.price) AS average_spending
FROM user AS u
    INNER JOIN purchased_item AS pi ON u.user_id = pi.user_id
GROUP BY pi.user_id;


# Incorrect GROUP BY because there are users without group
SELECT SQL_NO_CACHE IFNULL(u.user_group_id, email) AS user_group_id,
       COUNT(pi.user_id) AS total_purchases,
       SUM(pi.price) AS total_spendings,
       AVG(pi.price) AS average_spending
FROM user AS u
    LEFT JOIN user_group AS ug ON u.user_group_id = ug.user_group_id
    INNER JOIN purchased_item AS pi ON u.user_id = pi.user_id
GROUP BY user_group_id;


SELECT user_id, user_name, IFNULL(user_group_id, email) AS user_group_id
FROM user AS u;

SELECT SQL_NO_CACHE u.user_group_id,
       COUNT(pi.user_id) AS total_purchases,
       SUM(pi.price) AS total_spendings,
       AVG(pi.price) AS average_spending
FROM purchased_item AS pi
 INNER JOIN (
    SELECT user_id, user_name, IFNULL(user_group_id, email) AS user_group_id
    FROM user AS u
) AS u ON pi.user_id = u.user_id
GROUP BY u.user_group_id;

SELECT u.user_name,
       COUNT(pi.user_id) AS total_purchases,
       SUM(pi.price) AS total_spendings,
       AVG(pi.price) AS average_spending
FROM user AS u
         INNER JOIN purchased_item AS pi ON u.user_id = pi.user_id
GROUP BY pi.user_id
HAVING total_spendings >= 3000;

SELECT u.user_name,
       u.user_group_id,
       COUNT(pi.user_id) AS total_purchases,
       SUM(pi.price) AS total_spendings,
       AVG(pi.price) AS average_spending
FROM user AS u
     INNER JOIN purchased_item AS pi USING (user_id)
GROUP BY u.user_group_id, u.user_id
ORDER BY u.user_group_id, average_spending;


SELECT *
FROM purchased_item
LIMIT 5;


SELECT *
FROM purchased_item
LIMIT 4, 6;


SELECT t1.user_id, t1.tag_id, t1.tag, t2.user_id, t2.tag_id, t2.tag,  u1.user_group_id
FROM tag AS t1
 INNER JOIN user as u1
    ON t1.user_id = u1.user_id
 LEFT JOIN tag AS t2
   ON t1.tag = t2.tag
       AND t1.tag_id != t2.tag_id;


SELECT t1.tag_id, t1.tag, t2.tag_id, t2.tag, u1.user_group_id, u2.user_group_id
FROM tag AS t1
     INNER JOIN user as u1
        ON t1.user_id = u1.user_id
     LEFT JOIN tag AS t2
       ON t1.tag = t2.tag
           AND t1.tag_id != t2.tag_id
     LEFT JOIN user as u2
       ON t2.user_id = u2.user_id
WHERE u1.email = u2.email OR u1.user_group_id = u2.user_group_id;