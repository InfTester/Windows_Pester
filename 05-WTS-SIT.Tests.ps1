<#
	.NOTES
=========================================================================
		Created on: 01/04/2021
		Created by: Tony Law
		Filename:   Generic-WindowsTerminalServer.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute tests on a Windows Terminal Server to ensure that it can access its clients successfully once it is joined to a domain. 
		The script contains tests that are focussed on checking that the Remote Desktop Service is installed and the connection between the Terminal Server and its Clients, together with regression tests to ensure that there have been no adverse effects. 
		Note the following:
        	This script should be run with the json file containing the expected values for this specific server - 
		see the $jsonPath and $expectedValues variables.
        	The $file variable should be changed to an appropriate path.
		The services and processes listed in the param block may need to be edited depending on the server the script is being run against.

#>

param(
$RunningService = @('BrokerInfrastructure','BFE','EventSystem','CryptSvc','DcomLaunch','Dhcp','DPS','TrkWks','Dnscache','gpsvc',
'LSM','NlaSvc','nsi','PlugPlay','PcaSvc','SamSs','LanmanServer','SENS','SystemEventsBroker','Schedule','lmhosts','TimeBrokerSvc',
'UALSVC','UserManager','ProfSvc','WdNisSvc','WinDefend','EventLog','MpsSvc','Winmgmt','WinRM','W32Time'),
$StoppedService = @('bthserv','icssvc','PhoneSvc','WalletService'),
$RunningProcess = @('conhost','csrss','dwm','explorer','Idle','LogonUI','lsass','MpCmdRun','MsMpEng','NisSrv','rdpclip','RuntimeBroker',
'services','ShellExperienceHost','sihost','smss','svchost','System','spoolsv','taskhostw','wininit','winlogon')
)

$TermService = Get-Service TermService
$Tssdis = Get-Service Tssdis
$RDMS = Get-Service RDMS
$TSGateway = Get-Service TSGateway
$TermServLicensing = Get-Service TermServLicensing
$TscPubRPC = Get-Service TscPubRPC

$jsonPath = 'C:\Users\Administrator\Documents\W2019-WTS-Tests-i-095b091394c77b3c4.json'
$expectedValues = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).ConfigItems
$RDS_Installed = Get-WindowsFeature Remote-Desktop-Services
$Date = (Get-Date).AddDays(-1)

$WTSFW = Get-NetFirewallRule | Where { $_.Enabled �eq �True� �and $_.Direction �eq �Inbound� -and $_.DisplayName -like 'Remote *'}
$OS = Get-CimInstance Win32_OperatingSystem
$CS = Get-ciminstance Win32_ComputerSystem
$compinf = Get-ComputerInfo
$loc = Get-WinSystemLocale
$IP = Get-NetIpAddress | Where-Object {($_.AddressFamily -eq 'IPv4')-and ($_.InterfaceAlias -eq 'Ethernet')}
$IPconf = Get-NetIpConfiguration
$DHCP = Get-NetIPInterface | Where-Object {($_.AddressFamily -eq 'IPv4')-and ($_.InterfaceAlias -eq 'Ethernet')}
$FW = Get-NetFirewallProfile



Describe 'Windows Server 2019 Windows Terminal Server Tests' {

	Context 'Remote Desktop Services is installed' {
		It 'RDS is installed' {
			$RDS_Installed.InstallState | Should Be $expectedValues.RDSInstalled.InstallState
		}
    }

	Context 'Remote Desktop Services are running' {
		It 'TermService is Running' {
			$TermService.Status | Should Be 'Running'
		}
		It 'Tssdis is Running' {
			$Tssdis.Status | Should Be 'Running'
		}
		It 'RDMS is Running' {
			$RDMS.Status | Should Be 'Running'
		}
		It 'TSGateway is Running' {
			$TSGateway.Status | Should Be 'Running'
		}
		It 'TermServLicensing is Running' {
			$TermServLicensing.Status | Should Be 'Running'
		}
		It 'TscPubRPC is Running' {
			$TscPubRPC.Status | Should Be 'Running'
		}
	 }

	Context 'Check for Eventlog Errors ' {
        It 'There should be no WTS errors within the past 24 hours' {
			$ErrorVar = Get-EventLog -EntryType Error -Source '*Remote*' -LogName Application -After $Date
			$ErrorVar | Should BeNullOrEmpty
		}
	 }

    	Context 'Check inbound FireWall Rules' {
        $WTSFW | ForEach-Object {
		    It 'WTS inbound firewall rules should be enabled' {
			$WTSFW.Enabled | Should Be 'True'
			}
		}
   	}

	Context 'Regression tests - Host Details' {
		It 'Hostname is as expected' {
			$compinf.CsName | Should Be $expectedValues.Host.Name
		}

		It 'Domain is as expected' {
			$compinf.CsDomain | Should Be $expectedValues.Host.Domain
		}

		It 'Computer joined to a domain should be as expected' {
			$compinf.CsPartOfDomain | Should Be $expectedValues.Host.PartofDomain
		}

		It 'Domain role is as expected' {
			$compinf.CsDomainRole | Should Be $expectedValues.Host.DomainRole
		}
	}

	Context 'Regression tests - Network Configuration' {
		It 'IP address is as expected' {
			$IP.IPAddress | Should Be $expectedValues.NetworkConfig.IP
		}

		It 'Default gateway is as expected' {
			$IPconf.IPv4DefaultGateway.NextHop | Should Be $expectedValues.NetworkConfig.Gateway
		}
	
		It 'DNS Server is as expected' {
            		$DNS = IPCONFIG /ALL | Select-String 'DNS Servers'
			$DNS | Should Match $expectedValues.NetworkConfig.DNS
		}
        
	}

	Context 'Regression tests - Operating System' {
		It 'OS version is as expected' {
			$OS.Version | Should Be $expectedValues.OS.Version
		}

		It 'OS build number is as expected' {
			$OS.BuildNumber | Should Be $expectedValues.OS.BuildNumber
		}

		It 'OS architecture is as expected' {
			$OS.OSArchitecture | Should Be $expectedValues.OS.Architecture 
		}

		It 'OS install date is as expected' {
			$OS.InstallDate | Should Be $expectedValues.OS.InstallDate
		}
	}

	Context 'Regression tests - Windows Server' {
		It 'Windows installation type is as expected' {
			$compinf.WindowsInstallationType | Should Be $expectedValues.WindowsServer.InstallationType
		}

		It 'Windows product name is as expected' {
			$compinf.WindowsProductName | Should Be $expectedValues.WindowsServer.ProductName
		}

		It 'Windows edition is as expected' {
			$compinf.WindowsEditionId | Should Be $expectedValues.WindowsServer.Edition
		}

		It 'Windows version is as expected' {
			$compinf.WindowsCurrentVersion | Should Be $expectedValues.WindowsServer.Version
		}
		
		It 'Windows install date is as expected' {
			$compinf.WindowsInstallDateFromRegistry | Should Be $expectedValues.WindowsServer.InstallDate
		}
	}

	Context 'Regression tests - Locale Settings' {

		It 'Locale display name is as expected' {
			$loc.DisplayName | Should Be $expectedValues.Locale.DisplayName
		}

		It 'System language code is as expected' {
			$loc.LCID | Should Be $expectedValues.Locale.LCID
		}

		It 'Timezone is as expected' {
			$compinf.TimeZone | Should Be $expectedValues.Locale.TimeZone
		}
	}


	Context 'Regression tests - Lockdown' {
		It 'Private firewall should be enabled' {
			$FWpriv = $FW | Where Profile -eq 'Private'
			$FWpriv.Enabled | Should Be 'True'
		}

		It 'Public firewall should be enabled' {
			$FWpub = $FW | Where Profile -eq 'Public'
			$FWpub.Enabled | Should Be 'True'
		}

		It 'Domain firewall should be enabled' {
			$FWdom = $FW | Where Profile -eq 'Domain'
			$FWdom.Enabled | Should Be 'True'
		}

	}
	
	Context 'Regression tests - Services' {
		$RunningService | ForEach-Object {
        	It "[$_] should be running" {
                	(Get-Service $_).Status | Should Be 'Running'
                	}
		}
	

        $StoppedService | ForEach-Object {
        	It "[$_] should not be running" {
                	(Get-Service $_).Status | Should Be 'Stopped'
                }
		}
	}

	Context 'Regression tests - Processes' {
		$File = 'C:\Users\Administrator\Documents\RunningProcesses.txt'
		Get-Process | Out-File $File
        	$RunningProcess | ForEach-Object {
		    It "[$_] should be running" {
            		$File | Should Contain $_
            	}
		}	
    }
}
