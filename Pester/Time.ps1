## ServiceTests.Tests.ps1
describe 'The Time service on the local Server is set as per the status specified'  {

    $status = (Get-Service -Name 'W32Time').Status -as[string]
        $status1 = Get-Service -Name 'W32Time' | Select-Object Status

    it 'should be running' {
        $status | should Be 'Stopped'

    }
}