-- CREATE DATABASE IF NOT EXISTS fintrack_db;
USE fintrack_db;

-- === CREATE TABLE ===
-- Manajemen User
CREATE TABLE users (
	user_id INT(16) AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(100),
	email VARCHAR(30),
	password VARCHAR(20));
	
CREATE TABLE profiles (
	profile_id INT(16) AUTO_INCREMENT PRIMARY KEY,
	user_id INT(16) NOT NULL UNIQUE,
	full_name VARCHAR(50),
	phone_number VARCHAR(30),
	address VARCHAR(30),
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE);
	
-- Wallet
CREATE TABLE account_wallets(
	account_id INT(16) AUTO_INCREMENT PRIMARY KEY,
	user_id INT(16) NOT NULL, 
	account_name VARCHAR(100) NOT NULL,
	balance DECIMAL(18,2) NOT NULL DEFAULT 0.00,
	FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE);

CREATE TABLE physical_wallet(
	account_id INT(16) PRIMARY KEY,
    provider_name VARCHAR(50) NOT NULL DEFAULT 'Cash',
	account_number VARCHAR(20) DEFAULT NULL,
	FOREIGN KEY(account_id) REFERENCES account_wallets (account_id) ON DELETE CASCADE);

CREATE TABLE ewallet(
	account_id INT(16) PRIMARY KEY,
	provider_name VARCHAR(50) NOT NULL,
	account_number VARCHAR(20) DEFAULT NULL, 
	FOREIGN KEY(account_id) REFERENCES account_wallets (account_id) ON DELETE CASCADE);
	
-- Kategori Transaksi
CREATE TABLE categories(
	category_id INT(16) AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	type ENUM('income', 'expense') NOT NULL);

CREATE TABLE transactions (
	transaction_id INT(16) AUTO_INCREMENT PRIMARY KEY,
	user_id INT(16) NOT NULL,
	account_id INT(16) NOT NULL,
	category_id INT(16) NOT NULL,
	transaction_name VARCHAR(100) DEFAULT NULL,
	amount DECIMAL(18, 2) NOT NULL,
	transaction_type ENUM('income', 'expense') NOT NULL,
	transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	note VARCHAR(50),
	FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
	FOREIGN KEY (account_id) REFERENCES account_wallets (account_id) ON DELETE CASCADE,
	FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE RESTRICT); 

-- Budget
CREATE TABLE budgets(
	budget_id INT(16) AUTO_INCREMENT PRIMARY KEY,
	user_id INT(16) NOT NULL,
	category_id INT(16) NULL,
	category_budget DECIMAL(18,2) NULL,
	threshold DECIMAL(5, 2) NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
	FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE SET NULL);
		
-- Notification
CREATE TABLE notifications(
	notification_id INT(16) AUTO_INCREMENT PRIMARY KEY,
	user_id INT(16) NOT NULL,
	budget_id INT(16) NOT NULL,
	message VARCHAR(50) NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
	notification_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
	FOREIGN KEY (budget_id) REFERENCES budgets (budget_id) ON DELETE CASCADE);

-- Report
CREATE TABLE reports(
	report_id INT(16) AUTO_INCREMENT PRIMARY KEY,
	user_id INT(16) NOT NULL,
	account_id INT(16) NOT NULL,
	report_type ENUM('daily', 'weekly', 'monthly') NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	total_income DECIMAL(18, 2) NOT NULL DEFAULT 0.00,
	total_expense DECIMAL(18, 2) NOT NULL DEFAULT 0.00,
	ending_balance DECIMAL(18, 2) NOT NULL DEFAULT 0.00,
	generated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
	FOREIGN KEY (account_id) REFERENCES account_wallets (account_id) ON DELETE CASCADE);
	
-- Analysis
CREATE TABLE analysis (
   analysis_id INT(16) AUTO_INCREMENT PRIMARY KEY,
   user_id INT(16) NOT NULL,
   start_date DATE NOT NULL,
   end_date DATE NOT NULL,
   total_expense DECIMAL(18,2) NOT NULL DEFAULT 0.00,
   largest_category_id INT(16) NULL,
   average_expense DECIMAL(18,2) NOT NULL DEFAULT 0.00,
   generated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
   FOREIGN KEY (largest_category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

-- === PERATURAN AGAR DATA TIDAK TERDUPLIKAT ===
-- 1 users only have 1 email
ALTER TABLE users
ADD CONSTRAINT Unique_users_email
UNIQUE (email);

-- 1 user only have 1 profile
ALTER TABLE profiles
ADD CONSTRAINT Unique_profiles_user
UNIQUE (USER_ID);

-- 1 user only have 1 ewallet --
ALTER TABLE ewallet
ADD CONSTRAINT Unique_wallet
UNIQUE (account_id, provider_name, account_number);

-- 1 category only have 1 type
ALTER TABLE categories
ADD CONSTRAINT Unique_category_name_type
UNIQUE (name, type);

-- 1 category only have 1 budget
ALTER TABLE budgets
ADD CONSTRAINT Unique_budget_user_category
UNIQUE (user_id, category_id);

-- === GENERATE DATA DUMMY ===
-- generate categories
INSERT INTO categories (name, type) VALUES
('Salary',           'income'),
('Freelance',        'income'),
('Investment',       'income'),
('Bonus',           	'income'),
('Business',         'income'),
('Food & Drink',   	'expense'),
('Transportation',   'expense'),
('Shopping',         'expense'),
('Bill',         		'expense'),
('Entertainment',    'expense'),
('Health',       		'expense'),
('Education',      	'expense');

-- generate 50 users
DROP PROCEDURE IF EXISTS generate_users;
DELIMITER $$
CREATE PROCEDURE generate_users()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 50 DO
        INSERT INTO users (username, email, password)
        VALUES (CONCAT('user', i), CONCAT('user', i, '@mail.com'), CONCAT('fintrack', 100 + i));
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;
CALL generate_users();

-- generate profiles 
DROP PROCEDURE IF EXISTS generate_profiles;
DELIMITER $$
CREATE PROCEDURE generate_profiles()
BEGIN
    DECLARE done      INT DEFAULT 0;
    DECLARE uid       INT;
    DECLARE fn        VARCHAR(50);
    DECLARE mn        VARCHAR(50);
    DECLARE ln        VARCHAR(50);
    DECLARE sn        VARCHAR(50);
    DECLARE full_nm   VARCHAR(150);
    DECLARE phone     VARCHAR(20);
    DECLARE addr      VARCHAR(200);

    DECLARE first_names VARCHAR(500) DEFAULT 'Joni,Jingga,James,Misael,Nayya,Aila,Carmen,Nevy,Julio,Martin';
    DECLARE mid_names   VARCHAR(300) DEFAULT 'Nur,Dwi,Tri,Ayu,Rizky,Raharjo,Sungkono,Putra,Sakti';
    DECLARE last_names  VARCHAR(300) DEFAULT 'Wijaya,Saputra,Mahendra,Permata,Pratama,Santoso,Nugraha,Ramadhan,Lestari,Aulia';
    DECLARE streets     VARCHAR(200) DEFAULT 'Ketintang,A.Yani,Anggrek,Sudirman,Gayungan,Serigala';

    DECLARE cur CURSOR FOR SELECT user_id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO uid;
        IF done THEN LEAVE read_loop; END IF;

        -- Pick random element dari setiap list
        SET fn = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(first_names, ',', FLOOR(1 + RAND() * 15)), ',', -1));
        SET mn = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(mid_names,   ',', FLOOR(1 + RAND() * 9)),  ',', -1));
        SET ln = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(last_names,  ',', FLOOR(1 + RAND() * 10)), ',', -1));
        SET sn = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(streets,     ',', FLOOR(1 + RAND() * 6)),  ',', -1));

        -- 2 atau 3 kata (random)
        IF FLOOR(RAND() * 3) = 0
            THEN SET full_nm = CONCAT(fn, ' ', mn, ' ', ln);
            ELSE SET full_nm = CONCAT(fn, ' ', ln);
        END IF;

        SET phone = CONCAT('08', LPAD(FLOOR(RAND() * 10000000000), 10, '0'));
        SET addr  = CONCAT('Jl. ', sn, ' No ', FLOOR(1 + RAND() * 300));

        INSERT INTO profiles (user_id, full_name, phone_number, address)
        VALUES (uid, full_nm, phone, addr);

    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;
CALL generate_profiles();

-- update agar username & email mengikuti data profiles
UPDATE users u
JOIN profiles p ON p.user_id = u.user_id
SET
    u.username = CONCAT(LOWER(SUBSTRING(p.full_name, 1, LOCATE(' ', CONCAT(p.full_name, ' ')) - 1)), u.user_id),
    u.email    = CONCAT(LOWER(SUBSTRING(p.full_name, 1, LOCATE(' ', CONCAT(p.full_name, ' ')) - 1)), '.', u.user_id, '@gmail.com');
    
-- generate wallets
DROP PROCEDURE IF EXISTS generate_wallets;
DELIMITER $$
CREATE PROCEDURE generate_wallets()
BEGIN
    DECLARE done        INT DEFAULT 0;
    DECLARE uid         INT;
    DECLARE wallet_count INT;
    DECLARE i           INT;
    DECLARE wtype       INT;
    DECLARE new_acc_id  INT;

    DECLARE providers   VARCHAR(200) DEFAULT 'GoPay,OVO,Dana,ShopeePay,LinkAja';
    DECLARE provider    VARCHAR(50);
    DECLARE acc_names   VARCHAR(300) DEFAULT 'Dompet Utama,Tabungan Harian,Kas Pribadi,Dana Darurat,Dompet Digital';
    DECLARE acc_name    VARCHAR(100);

    DECLARE cur CURSOR FOR SELECT user_id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO uid;
        IF done THEN LEAVE read_loop; END IF;

        SET wallet_count = 1 + FLOOR(RAND() * 2); -- 1 atau 2
        SET i = 1;

        WHILE i <= wallet_count DO
            SET acc_name = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(acc_names, ',', FLOOR(1 + RAND() * 5)), ',', -1));

            INSERT INTO account_wallets (user_id, account_name, balance)
            VALUES (uid, acc_name, ROUND(RAND() * 9000000 + 100000, 2));

            SET new_acc_id = LAST_INSERT_ID();

            -- 0 = physical, 1 = ewallet
            SET wtype = FLOOR(RAND() * 2);

            IF wtype = 0 THEN
                INSERT INTO physical_wallet (account_id) VALUES (new_acc_id);
            ELSE
                SET provider = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(providers, ',', FLOOR(1 + RAND() * 5)), ',', -1));
                INSERT INTO ewallet (account_id, provider_name, account_number)
                VALUES (new_acc_id, provider, CONCAT('08', LPAD(FLOOR(RAND() * 10000000000), 10, '0')));
            END IF;

            SET i = i + 1;
        END WHILE;

    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;
CALL generate_wallets();


-- generate budgets

DROP PROCEDURE IF EXISTS generate_budgets;
DELIMITER $$
CREATE PROCEDURE generate_budgets()
BEGIN
    DECLARE done        INT DEFAULT 0;
    DECLARE uid         INT;
    DECLARE cat_id      INT;
    DECLARE cat_bud     DECIMAL(18,2);

    DECLARE cur CURSOR FOR SELECT user_id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO uid;
        IF done THEN LEAVE read_loop; END IF;

        -- Ambil random category bertipe expense
        SELECT category_id INTO cat_id
        FROM categories
        WHERE type = 'expense'
        ORDER BY RAND()
        LIMIT 1;

        SET cat_bud = ROUND(500000 + (RAND() * 3000000), 2);

        INSERT INTO budgets (user_id, category_id, category_budget, threshold, start_date, end_date)
        VALUES (
            uid,
            cat_id,
            cat_bud,
            ROUND(50 + RAND() * 40, 2),                         -- threshold 50–90%
            DATE_FORMAT(NOW(), '%Y-%m-01'),                      -- awal bulan ini
            LAST_DAY(NOW())                                      -- akhir bulan ini
        );

    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;
CALL generate_budgets();

-- generate transactions

DROP PROCEDURE IF EXISTS generate_transactions;
DELIMITER $$
CREATE PROCEDURE generate_transactions()
BEGIN
    DECLARE done        INT DEFAULT 0;
    DECLARE uid         INT;
    DECLARE acc_id      INT;
    DECLARE cat_id      INT;
    DECLARE tx_count    INT;
    DECLARE i           INT;
    DECLARE tx_type     ENUM('income','expense');
    DECLARE tx_amount   DECIMAL(18,2);
    DECLARE tx_date     DATETIME;
    DECLARE cat_type    VARCHAR(10);

    DECLARE tx_names    VARCHAR(500) DEFAULT 'Belanja Bulanan,Transfer,Bayar Listrik,Makan Siang,Gaji Bulan Ini,Freelance Project,Top Up,Bayar BPJS,Beli Pulsa,Ojek Online,Nonton Bioskop,Beli Obat,Kursus Online,Dividen,Bonus Proyek';

    DECLARE cur CURSOR FOR SELECT user_id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO uid;
        IF done THEN LEAVE read_loop; END IF;

        SET tx_count = 5 + FLOOR(RAND() * 6); -- 5–10
        SET i = 1;

        WHILE i <= tx_count DO

            -- Ambil random account milik user ini
            SELECT account_id INTO acc_id
            FROM account_wallets
            WHERE user_id = uid
            ORDER BY RAND()
            LIMIT 1;

            -- Ambil random category
            SELECT category_id, type INTO cat_id, cat_type
            FROM categories
            ORDER BY RAND()
            LIMIT 1;

            SET tx_type   = cat_type;
            SET tx_amount = ROUND(10000 + RAND() * 990000, 2);
            SET tx_date   = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 90) DAY); -- 90 hari terakhir

            INSERT INTO transactions (user_id, account_id, category_id, transaction_name, amount, transaction_type, transaction_date, note)
            VALUES (
                uid,
                acc_id,
                cat_id,
                TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(tx_names, ',', FLOOR(1 + RAND() * 15)), ',', -1)),
                tx_amount,
                tx_type,
                tx_date,
                NULL
            );

            SET i = i + 1;
        END WHILE;

    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;
CALL generate_transactions();
