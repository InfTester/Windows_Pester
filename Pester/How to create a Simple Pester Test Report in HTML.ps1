describe 'MyComputer' {

	it 'Remote Desktop Services should be Stoppred' {
	(Get-Service -Name Termservice).status | should -be 'Stopped'
	}
	it 'This scritpt should exist' {
	(Test-path -Path 'c:\Users\tonyl\How to create a Simple Pester Test Report in HTML.ps1') | should -be $true
}}
