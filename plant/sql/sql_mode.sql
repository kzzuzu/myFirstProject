/* 查詢目前的sql_mode */
SELECT @@GLOBAL.sql_mode;

SELECT @@SESSION.sql_mode;

SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));