
--In this article We are going to understand the basics of SQLOS - CPU scheduling.
--In high level:

--1. When an user connects to SQL Server instance, unique connection id and session id is assigned to the user.
select * from sys.dm_exec_connections

--2. Queries being executed by the user sessions (requests in other words) are available in below DMVs
select * from sys.dm_exec_requests
--select * from sys.dm_exec_sql_text(plan_handle)

--3. Once the execution plan of a query is generated, it is divided into one or more tasks. Number of tasks depends on query parallelism.
select * from sys.dm_os_tasks

--4. Each task is assigned to a worker. A worker is where the work actually gets done.
--Maximum number of workers (assigned to SQL Server) depends on the number of CPUs and hardware architecture (32 bit or 64 bit)
--Further read: http://blogs.msdn.com/b/sqlsakthi/archive/2011/03/14/max-worker-threads-and-when-you-should-change-it.aspx
select * from sys.dm_os_workers

--5. Each worker is associated with a thread.
select * from sys.dm_os_threads

--6. Scheduler schedules CPU time for a task/worker. 
--When SQL Server service starts, it creates one scheduler for each logical CPU. (few more schedulers for internal purpose).
--During this period, Scheduler may keep a task in RUNNING or RUNNABLE or SUSPENDED state for various reasons.
select * from sys.dm_os_schedulers

--7. Once the task is completed, all consumed resources are freed.