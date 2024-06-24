## ServerNameTests.Tests.ps1
describe 'The Desktop/Server Name should be correct as specified'  {

    $Name = (Get-WmiObject -Class win32_computersystem -ComputerName localhost | Select-Object Name).Name

    it 'should be Correct' {
        $Name | should Be 'DESKTOP-0NI678D'

    }
}