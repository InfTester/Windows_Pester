Invoke-Pester -Path 'C:\Users\tonyl\OneDrive\TVIAAS\Scripting\NetworkIPAdd.ps1' -OutputFormat NUnitxml -OutputFile 'C:\Users\tonyl\OneDrive\TVIAAS\Scripting\IPResults.xml' -Quiet
Invoke-Item 'C:\Users\tonyl\OneDrive\TVIAAS\Scripting\IPResults.xml'
$con = Get-Computerinfo
$con.OsSuites[0]
$con.OsSuites[1]
$con.OsSuites[2]
$con.OsHotFixes
$hotFixes = $con.OsHotFixes | sort HotFixID