<#
	.NOTES
=========================================================================
		Created on: 30/03/2021
		Created by: Tony Law
		Filename:   WSUS_SIT.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute the system integration level tests of a server with the 
		Windows Server Update Services role. It should be run following the configuration of the WSUS server.
		Note the following:
        	This script should be run with json files containing the expected values for specific servers - 
		see the $jsonPath and $expectedValues variables.
        	The file paths should be changed where necessary.
#>

param(
$WSUSServices = @('WsusService','W3SVC'),
$RunningService = @('BrokerInfrastructure','BFE','EventSystem','CryptSvc','DcomLaunch','Dhcp','DPS','TrkWks','Dnscache','gpsvc',
'LSM','NlaSvc','nsi','PlugPlay','SamSs','LanmanServer','SENS','SystemEventsBroker','Schedule','lmhosts','TimeBrokerSvc',
'UALSVC','UserManager','ProfSvc','WdNisSvc','WinDefend','EventLog','MpsSvc','Winmgmt','WinRM','W32Time'),
$StoppedService = @('bthserv','icssvc','PhoneSvc','WalletService'),
$RunningProcess = @('conhost','csrss','dwm','explorer','Idle','LogonUI','lsass','MsMpEng','NisSrv','rdpclip','RuntimeBroker',
'services','ShellExperienceHost','sihost','smss','svchost','System','spoolsv','taskhostw','wininit','winlogon','WmiPrvSE')
)

#$jsonPath = 'C:\WkDir\jsonfile.json'

$Feature = Get-WindowsFeature UpdateServices
$Date = (Get-Date).AddDays(-1)
#$WSUSFW = Get-NetFirewallRule | Where {($_Direction �eq �Inbound�) -and ($_.DisplayName -eq 'WSUS')}

$OS = Get-CimInstance Win32_OperatingSystem
$compinf = Get-ComputerInfo
$loc = Get-WinSystemLocale
$IP = Get-NetIpAddress | Where-Object {($_.AddressFamily -eq 'IPv4')-and ($_.InterfaceAlias -eq 'Ethernet')}
$IPconf = Get-NetIpConfiguration
$FW = Get-NetFirewallProfile
$ProcessFile = 'C:\WkDir\RunningProcesses.txt'

Describe 'WSUS system integration tests'{
	Context 'WSUS tests' {

		It 'Update services role should be installed' {
			$Feature.InstallState | Should Be 'Installed'
		}

		$WSUSServices | ForEach-Object {
        	It "[$_] should be running" {
            		(Get-Service $_).Status | Should Be 'Running'
        	}}

		It 'There should be no WSUS errors within the past 24 hours' {
			$Error = Get-EventLog -EntryType Error -Source 'Windows Server Update Services' -LogName Application -After $Date
			$Error | Should BeNullOrEmpty
		}


		It 'WSUS server should be able to reach the client server info page' {
			$Webrequest = Invoke-WebRequest http://WSUS01.tviaas.local:8530/ClientWebService/client.asmx
            		$Webrequest.StatusCode | Should Be 200
		}

		$WSUSFW | ForEach-Object {
		It 'WSUS inbound firewall rules should be enabled' {
			$WSUSFW.Enabled | Should Be 'True'
		}}

		It 'Update services log files should exist' {
			Test-Path 'C:\Program Files\Update Services\LogFiles\Change.log' | Should Be 'True'
            		Test-Path 'C:\Program Files\Update Services\LogFiles\SoftwareDistribution.log' | Should Be 'True'
		}
	}

	Context 'Regression tests - Host Details' {
		It 'Hostname is as expected' {
			$compinf.CsName | Should Be $expectedValues.Host.Name
		}

		It 'Computer should be joined to a domain' {
			$compinf.CsPartOfDomain | Should Be $expectedValues.Host.PartofDomain
		}

		It 'Domain is as expected' {
			$compinf.CsDomain | Should Be $expectedValues.Host.Domain
		}

		It 'Domain role is as expected' {
			$compinf.CsDomainRole | Should Be $expectedValues.Host.DomainRole
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

	Context 'Regression tests - Network Configuration' {
		It 'IP address is as expected' {
			$IP.IPAddress | Should Be $expectedValues.NetworkConfig.IP
		}

		It 'Default gateway is as expected' {
			$IPconf.IPv4DefaultGateway.NextHop | Should Be $expectedValues.NetworkConfig.Gateway
		}

		It 'Subnet mask is as expected' { 
            $Subnet = IPCONFIG /ALL | Select-String 'Subnet Mask'
			$Subnet | Should Match $expectedValues.NetworkConfig.Subnet	
		}
	
		It 'DNS Server is as expected' {
            $DNS = IPCONFIG /ALL | Select-String 'DNS Servers'
			$DNS | Should Match $expectedValues.NetworkConfig.DNS
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
		Get-Process | Out-File $ProcessFile
        	$RunningProcess | ForEach-Object {
		    It "[$_] should be running" {
            		$ProcessFile | Should Contain $_
            	}
		}
	}
}