Describe 'Check Stopped Services are in the state of Stopped' {
    $StoppedServices = @{AJRouter = 'Stopped'}, @{ALG = 'Stopped'}, @{AppIDSvc = 'Stopped'}, @{AppReadiness = 'Stopped'},  @{autotimesvc = 'Stopped'}, @{AxInstSV = 'Stopped'}, @{W32Time = 'Stopped'}
	It "StoppedServices" {
    param ($StoppedServices)
        (Get-Service $StoppedServices).Status |
        Should Be 'Stopped'
	}
}

<#

Describe 'Server Services'{ 
   Context 'Running Services' {
		It 'DHCP should be running' {
		    $s = Get-Service -Name 'dhcp' -ComputerName 'localhost'
			$s.status | Should -Be "running"
			
		}
		It 'Windows Search should be running' {
		    $s = Get-Service -Name 'WSearch' -ComputerName 'localhost'
			$s.status | Should -Be "running"
			
		}
	}
}
#>