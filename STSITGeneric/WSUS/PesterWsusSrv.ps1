## ServiceTests.Tests.ps1
describe 'The wuauserv service on localhost' {

    $serverName = $computername


    $status = (Get-Service -ComputerName $servername -Name 'wuauserv').Status

    it 'should be running' {
        $status | should -Be Stopped

    }
}