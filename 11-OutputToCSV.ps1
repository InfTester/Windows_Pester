# Runs the pester test script at the path specified and passes the results to a variable
Invoke-Pester -Script @{Path = 'C:\WkDir\FileName.Tests.ps1'} -PassThru -OutVariable Results -Show None

# Exports the results from the variable to an xml file at the path specified
$Results | Export-Clixml -Path 'C:\WkDir\PesterExport.xml'

# Exports the results in a csv file in human-readable format
$PesterResults = Import-Clixml -Path 'C:\WkDir\PesterExport.xml'
Foreach ($Result in $PesterResults.TestResult) {
    [System.Array]$Object += [PSCustomObject]@{
        Describe = $Result.Describe.TrimEnd(':')
        Context = $Result.Context.TrimEnd(':')
        Expected = $Result.Name.TrimEnd(':')
        Result = $Result.Result
        TimeTaken = $Result.Time.TotalMilliseconds
    }
} 
$Object | Export-Csv -Path 'C:\WkDir\PesterExport.csv' -NoTypeInformation
