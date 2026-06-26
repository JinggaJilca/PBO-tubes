-- === CREATE & USE DB ===
CREATE DATABASE IF NOT EXISTS fintrack_db;
USE fintrack_db;

-- === DELETE DATA ===
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

-- === DELETE COLL ===
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS analysis_category_percentage;
DROP TABLE IF EXISTS analysis;
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS budgets;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS physical_wallet;
DROP TABLE IF EXISTS ewallet;
DROP TABLE IF EXISTS account_wallets;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

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

-- === CHECK HUBUNGAN TABEL ===
SELECT 
    CONSTRAINT_NAME AS FK_Name,
    TABLE_NAME AS ChildTable,
    REFERENCED_TABLE_NAME AS ParentTable
FROM 
    information_schema.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'pbo-fintrack' 
    AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY 
    ParentTable;
