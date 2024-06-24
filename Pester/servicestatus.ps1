## ServiceTests.Tests.ps1
describe 'The Time service on the local Server is set as per the status specified'  {

    $status = (Get-Service -Name 'W32Time').Status

    it 'should be running' {
        (Get-Service -Name 'W32Time').Status | should -Be 'Stopped'

    }
}