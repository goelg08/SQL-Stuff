SELECT s2.text, 
session_id,
start_time,
a.status, 
cpu_time, 
blocking_session_id, 
wait_type,
wait_time, 
wait_resource, 
open_transaction_count,sp.program_name,sp.loginame,sp.hostname,qp.query_plan
FROM sys.dm_exec_requests a
CROSS APPLY sys.dm_exec_sql_text(a.sql_handle) AS s2  left join sys.sysprocesses sp on a.session_id=sp.spid
CROSS apply sys.dm_exec_query_plan (a.plan_handle) AS qp  --for exec plan info
WHERE a.status not in ('background','suspended') order by a.cpu_time desc
