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