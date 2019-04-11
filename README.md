# LBRscript
script for "Local Bitnami Redmine"

## redmineBackup.bat
バックアップ用バッチファイル
C:\Bitnami\redmine 配下に配置

use_redmine.batを起動して、redmineBackup.bat実行するとバックアップ開始

＜前提＞
・C:\Bitnami\redmine_backupは作成されている
・Redmineのインストールディレクトリは C:\Bitnami\redmine

## redmineRestore.bat
リストア用バッチファイル
C:\Bitnami\redmine 配下に配置

use_redmine.batを起動して、redmineRestore.bat実行するとバックアップ開始

＜前提＞
・C:\Bitnami\redmine_backupは作成されている
・日付を引数に取る（YYYYMMDDの想定)
・Redmineのインストールディレクトリは C:\Bitnami\redmine
