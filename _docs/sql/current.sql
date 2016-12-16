
select * from sys.dm_exec_connections
select * from sys.dm_exec_sessions
select * from sys.dm_exec_requests

select * from sys.dm_os_schedulers
select * from sys.dm_os_threads
select * from sys.dm_os_workers

SELECT max_workers_count FROM sys.dm_os_sys_info

exec sp_who

exec sp_configure 'show advanced options',0
reconfigure
