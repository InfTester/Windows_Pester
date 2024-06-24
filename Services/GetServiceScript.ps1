 Get-Service |
Select-Object -Property Name,Status,@{Name = 'Timestamp';Expression =
{ Get-Date -Format 'dd-yy hh:mm:ss' }} |
Export-Excel C:\Users\tonyl\OneDrive\TVIAAS\Services\ServiceStates.xlsx -WorksheetName 'Services' -Append