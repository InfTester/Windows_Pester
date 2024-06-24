<#PS C:\WINDOWS\system32> Get-EventLog -LogName System -Newest 1000 | Where-Object {$_.EventID -eq '1074'} | ft MachineName, UserName, TimeGenerated -AutoSize


MachineName     UserName              TimeGenerated      
-----------     --------              -------------      
DESKTOP-0NI678D NT AUTHORITY\SYSTEM   21/11/2020 01:45:19
DESKTOP-0NI678D DESKTOP-0NI678D\tonyl 21/11/2020 01:43:20
DESKTOP-0NI678D NT AUTHORITY\SYSTEM   12/11/2020 21:30:31
#>
