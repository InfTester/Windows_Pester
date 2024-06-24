 Get-Process |
Select-Object -Property *,@{Name = 'Timestamp';Expression = { Get-Date -Format 'dd-MM-yy hh:mm:ss' }} |
Export-Excel C:\Users\tonyl\OneDrive\TVIAAS\Processes\Processes.xlsx -WorksheetName 'ProcessesOverTime' -Append
