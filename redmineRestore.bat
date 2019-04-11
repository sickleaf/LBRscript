@echo off

	cd /d %~dp0

echo;
echo ******[BEGIN] REDMINE RESTORE

	set REDMINE_ROOT=C:\Bitnami\redmine
	set RESTORE_ROOT=C:\Bitnami\redmine_backup
	set TODAY=%1

	set RESTORE_DIR=%RESTORE_ROOT%\%TODAY%


	cd %REDMINE_ROOT%\apps\redmine\htdocs
	set DBUSERCMD="cat config\database.yml | sed -n '/bitnami_redmine/,/username/p' |  awk '{print $NF}' | tail -1"
	set DBPASSCMD="cat config\database.yml | sed -n '/bitnami_redmine/,/password/p' |  awk '{print $NF}' | tail -1"

	for /f "usebackq delims=" %%u in (`%DBUSERCMD%`) do set DBUSER=%%u
	for /f "usebackq delims=" %%p in (`%DBPASSCMD%`) do set DBPASS=%%p

echo;
echo ***[BEGIN] RESTORE DB DATA [%RESTORE_DIR%\backup.sql]
	mysql --user=%DBUSER% --password=%DBPASS% bitnami_redmine < %RESTORE_DIR%\backup.sql
echo ***[ END ] RESTORE DB DATA [%RESTORE_DIR%\backup.sql]
echo;

echo;
echo ***[BEGIN] RESTORE CONFIG DIR (1/5)
	rmdir /S /Q config
	cp -pR %RESTORE_DIR%\config config
echo ***[ END ] RESTORE CONFIG DIR (1/5)
echo;

echo;
echo ***[BEGIN] RESTORE FILES DIR (2/5)
	rmdir /S /Q files
	cp -pR %RESTORE_DIR%\files files
echo ***[ END ] RESTORE FILES DIR (2/5)
echo;

echo;
echo ***[BEGIN] RESTORE LOG DIR (3/5)
	rmdir /S /Q log
	cp -pR %RESTORE_DIR%\log log
echo ***[ END ] RESTORE LOG DIR (3/5)
echo;

echo;
echo ***[BEGIN] RESTORE PLUGINS DIR (4/5)
	rmdir /S /Q plugins
	cp -pR %RESTORE_DIR%\plugins plugins
echo ***[ END ] RESTORE PLUGINS DIR (4/5)
echo;

echo;
echo ***[BEGIN] RESTORE PUBLIC DIR (5/5)
	rmdir /S /Q public
	cp -pR  %RESTORE_DIR%\public public
echo ***[ END ] RESTORE PUBLIC DIR (5/5)
echo;


	cd /d %~dp0

echo ******[ END ] REDMINE RESTORE
echo;
