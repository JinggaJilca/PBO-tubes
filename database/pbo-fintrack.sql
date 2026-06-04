USE fintrack_db;

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
	total_budget DECIMAL(18, 2) NOT NULL,
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

CREATE TABLE analysis_category_percentage (
   id INT(16) AUTO_INCREMENT PRIMARY KEY,
   analysis_id INT(16) NOT NULL,
   category_id INT(16) NOT NULL,
   percentage DECIMAL(5,2) NOT NULL DEFAULT 0.00,
   total_amount DECIMAL(18,2) NOT NULL DEFAULT 0.00,
   FOREIGN KEY (analysis_id) REFERENCES analysis(analysis_id) ON DELETE CASCADE,
   FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- Delete Data
DELETE FROM analysis_category_percentage;
DELETE FROM analysis;

DELETE FROM reports;
DELETE FROM notifications;

DELETE FROM transactions;

DELETE FROM budgets;

DELETE FROM physical_wallet;
DELETE FROM ewallet;

DELETE FROM account_wallets;

DELETE FROM categories;
DELETE FROM profiles;

DELETE FROM users;

-- Reset IDENTITY (Run After Delete Data)
DBCC CHECKIDENT ('users', RESEED, 0);
DBCC CHECKIDENT ('profiles', RESEED, 0);
DBCC CHECKIDENT ('account_wallets', RESEED, 0);
DBCC CHECKIDENT ('categories', RESEED, 0);
DBCC CHECKIDENT ('transactions', RESEED, 0);
DBCC CHECKIDENT ('budgets', RESEED, 0);
DBCC CHECKIDENT ('notifications', RESEED, 0);
DBCC CHECKIDENT ('reports', RESEED, 0);
DBCC CHECKIDENT ('analysis', RESEED, 0);
DBCC CHECKIDENT ('analysis_category_percentage', RESEED, 0);

-- Check Hubungan Tabel
SELECT
    fk.name AS FK_Name,
    OBJECT_NAME(fk.parent_object_id) AS ChildTable,
    OBJECT_NAME(fk.referenced_object_id) AS ParentTable
FROM sys.foreign_keys fk
ORDER BY ParentTable;

-- PERATURAN AGAR DATA TIDAK TERDUPLIKAT --
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

-- 1 analysis only have 1 category
ALTER TABLE analysis_category_percentage
ADD CONSTRAINT Unique_analysis_category
UNIQUE (analysis_id, category_id);