@echo off

cd /d %~dp0

	echo;
	echo ******[BEGIN] REDMINE BACKUP

set REDMINE_ROOT=C:\Bitnami\redmine
set BACKUP_ROOT=C:\Bitnami\redmine_backup
set TODAY=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%

set BACKUP_DIR=%BACKUP_ROOT%\%TODAY%

	echo;
	echo ***[BEGIN] MAKE BACKUPDIR [%BACKUP_DIR%]
cd %REDMINE_ROOT%\apps\redmine\htdocs
mkdir %BACKUP_DIR%
	echo ***[ END ] MAKE BACKUPDIR [%BACKUP_DIR%]
	echo;

set DBUSERCMD="cat config\database.yml | sed -n '/bitnami_redmine/,/username/p' |  awk '{print $NF}' | tail -1"
set DBPASSCMD="cat config\database.yml | sed -n '/bitnami_redmine/,/password/p' |  awk '{print $NF}' | tail -1"

for /f "usebackq delims=" %%u in (`%DBUSERCMD%`) do set DBUSER=%%u
for /f "usebackq delims=" %%p in (`%DBPASSCMD%`) do set DBPASS=%%p


	echo;
	echo ***[BEGIN] BACKUP DB DATA [%BACKUP_DIR%\backup.sql]
mysqldump --user=%DBUSER% --password=%DBPASS% bitnami_redmine > %BACKUP_DIR%\backup.sql
	echo ***[ END ] BACKUP DB DATA [%BACKUP_DIR%\backup.sql]
	echo;

	echo;
	echo ***[BEGIN] BACKUP CONFIG DIR (1/5)
cp -pR config %BACKUP_DIR%
	echo ***[ END ] BACKUP CONFIG DIR (1/5)
	echo;

	echo;
	echo ***[BEGIN] BACKUP FILES DIR (2/5)
cp -pR files %BACKUP_DIR%
	echo ***[ END ] BACKUP FILES DIR (2/5)
	echo;

	echo;
	echo ***[BEGIN] BACKUP LOG DIR (3/5)
cp -pR log %BACKUP_DIR%
	echo ***[ END ] BACKUP LOG DIR (3/5)
	echo;

	echo;
	echo ***[BEGIN] BACKUP PLUGINS DIR (4/5)
cp -pR plugins %BACKUP_DIR%
	echo ***[ END ] BACKUP PLUGINS DIR (4/5)
	echo;

	echo;
	echo ***[BEGIN] BACKUP PUBLIC DIR (5/5)
cp -pR public %BACKUP_DIR%
	echo ***[ END ] BACKUP PUBLIC DIR (5/5)
	echo;


cd /d %~dp0

	echo ******[ END ] REDMINE BACKUP [%BACKUP_DIR%]
	echo;
