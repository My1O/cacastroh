USE AdventureWorks2019
GO

-- Create a database on multiple fileGroups

SELECT *
FROM sys.backup_devices
GO

EXEC sp_dropdevice 'AdventureWorks2019_backupDevice','delfile';
GO

--creat primer backup
BACKUP DATABASE AdventureWorks2019
TO AdventureWorks2019_backupDevice
WITH FORMAT, INIT, NAME = N'AdventureWorks_full_backup';
GO