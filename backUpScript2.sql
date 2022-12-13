-- ===========================

-- Backup Database Template
-- ===========================
BACKUP DATABASE AdventureWorks2019
	TO  DISK = N'C:\Ing.Sis\BD II\PracticaVideos\BackUPScripts\DATA\AdventureWorks2019_full.bak' 
WITH 
	NOFORMAT, 
	COMPRESSION,
	NOINIT,  
	NAME = N'AdventureWorks2019-Full database Backup', 
	SKIP, 
	STATS = 10;
GO

use AdventureWorks2019
go
--Crear dispositivo de almacenamiento
EXEC sp_addumpdevice 'disk', 'AdventureWorks2019_backupDevice',
'C:\Ing.Sis\BD II\PracticaVideos\BackUPScripts\DATA\AdventureWorks2019_backupDevice.bak';
GO

SELECT *
FROM sys.backup_devices
GO

EXEC sp_dropdevice 'AdventureWorks2019_backupDevice','delfile';
GO

--creat primer device backup
BACKUP DATABASE AdventureWorks2019
TO AdventureWorks2019_backupDevice
WITH FORMAT, INIT, NAME = N'AdventureWorks full backup';
GO

--restaurar BD full
RESTORE HEADERONLY FROM AdventureWorks2019_backupDevice
GO

--Restaurar Backup anterior
Restore database AwExamenBDII
FROM AdventureWorks2019_backupDevice
WITH FILE =1,
MOVE N'AdventureWorks2019_backupDevice' TO 'C:\Ing.Sis\BD II\PracticaVideos\BackUPScripts\DATA\AdventureWorks2019_backupDevice.bak',
nounload, REPLACE, STATS = 10
GO

-- Restaura backup database con nombre predeterminado

DECLARE @BACKUP_NAME Varchar(100)
SET @BACKUP_NAME = 'AdventureWorks full backup' + FORMAT(GETDATE(), 'yyyyMMdd_hhmmss');
GO


