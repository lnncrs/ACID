
declare @spid int = 54
kill 54

-- Query 1: User Connection and Query as Request.
SELECT  REQ.connection_id, REQ.database_id, REQ.session_id, REQ.command, REQ.request_id, REQ.start_time, REQ.task_address, QUERY.text
FROM SYS.dm_exec_requests req Cross apply sys.dm_exec_sql_text (req.sql_handle) as query
WHERE req.session_id = 54

-- Query 2: User quey is divided as 3 Tasks (Parallelism forced)
SELECT  task.task_address, task.parent_task_address, task.task_state, REQ.request_id, REQ.database_id, REQ.session_id, REQ.start_time, REQ.command, REQ.connection_id, REQ.task_address, QUERY.text
FROM SYS.dm_exec_requests req INNER JOIN sys.dm_os_tasks task on req.task_address = task.task_address or req.task_address = task.parent_task_address Cross apply sys.dm_exec_sql_text (req.sql_handle) as query
WHERE req.session_id = 54

-- Query 3: Each task is assigned to worker
SELECT  worker.worker_address, worker.last_wait_type, worker.state, task.task_address, task.parent_task_address, task.task_state, REQ.request_id, REQ.database_id, REQ.session_id, REQ.start_time, REQ.command, REQ.connection_id, REQ.task_address, QUERY.text
FROM SYS.dm_exec_requests req INNER JOIN sys.dm_os_tasks task  on req.task_address = task.task_address or req.task_address = task.parent_task_address INNER JOIN SYS.dm_os_workers WORKER ON TASK.task_address = WORKER.task_address Cross apply sys.dm_exec_sql_text (req.sql_handle) as query
WHERE req.session_id = 54

-- Query 4: User request as Tasks. Task assigned to worker. Each worker is associated with a thread
-- User Query as Request becomes Task(s)
-- Task is given to available Worker
-- Threads associated with Workers
SELECT  thread.thread_address, thread.priority, thread.processor_group, thread.started_by_sqlservr, worker.worker_address, worker.last_wait_type, worker.state, task.task_address, task.parent_task_address, task.task_state, REQ.request_id, REQ.database_id, REQ.session_id, REQ.start_time, REQ.command, REQ.connection_id, REQ.task_address, QUERY.text
FROM SYS.dm_exec_requests req INNER JOIN sys.dm_os_tasks task  on req.task_address = task.task_address or req.task_address = task.parent_task_address INNER JOIN SYS.dm_os_workers WORKER ON TASK.task_address = WORKER.task_address INNER JOIN sys.dm_os_threads thread on worker.thread_address = thread.thread_address Cross apply sys.dm_exec_sql_text (req.sql_handle) as query
WHERE req.session_id = 54

-- Query 5: CPU time is scheduled for task by Scheduler
-- User Query as Request becomes Task(s)
-- Task is given to available Worker
-- Threads associated with Workers
-- Schedulers associated with CPU schedules CPU time for Workers
SELECT  sch.scheduler_address, sch.runnable_tasks_count, sch.cpu_id, sch.status, thread.thread_address, thread.priority, thread.processor_group, thread.started_by_sqlservr, worker.worker_address, worker.last_wait_type, worker.state, task.task_address, task.parent_task_address, task.task_state, REQ.request_id, REQ.database_id, REQ.session_id, REQ.start_time, REQ.command, REQ.connection_id, REQ.task_address, QUERY.text
FROM SYS.dm_exec_requests req INNER JOIN sys.dm_os_tasks task  on req.task_address = task.task_address or req.task_address = task.parent_task_address INNER JOIN SYS.dm_os_workers WORKER ON TASK.task_address = WORKER.task_address INNER JOIN sys.dm_os_threads thread on worker.thread_address = thread.thread_address INNER JOIN sys.dm_os_schedulers sch on sch.scheduler_address = worker.scheduler_address Cross apply sys.dm_exec_sql_text (req.sql_handle) as query
WHERE req.session_id = 54

