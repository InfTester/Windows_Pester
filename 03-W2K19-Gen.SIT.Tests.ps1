<#
	.NOTES
=========================================================================
		Created on: 21/04/2021
		Created by: Tony Law
		Filename:   Generic_SIT_Tests.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute the system integration level (SIT) tests for a Windows Server where the tests are generic, ie not dependent
		on the server's role. 
		Note the following:
        	This script should be run with json files containing the expected values for specific servers - see the $jsonPath and $expectedValues variables.
        	The file paths should be changed where necessary.
#>

param(
$DummyParam,
$RunningService = @('BrokerInfrastructure','BFE','EventSystem','CryptSvc','DcomLaunch','Dhcp','DPS','Dnscache','gpsvc',
'LSM','NlaSvc','nsi','PlugPlay','SamSs','LanmanServer','SENS','SystemEventsBroker','Schedule','lmhosts','TimeBrokerSvc',
'UALSVC','UserManager','ProfSvc','WdNisSvc','WinDefend','EventLog','MpsSvc','Winmgmt','WinRM','W32Time'),
$StoppedService = @('bthserv','icssvc','PhoneSvc','WalletService'),
$RunningProcess = @('conhost','csrss','dwm','explorer','Idle','LogonUI','lsass','MsMpEng','NisSrv','rdpclip','RuntimeBroker',
'services','ShellExperienceHost','sihost','smss','svchost','System','spoolsv','taskhostw','wininit','winlogon','WmiPrvSE')
)

$jsonPath = 'C:\Users\Administrator\Documents\Generic_SIT_i-0cbb6eab1d8025286.json'
$expectedValues = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).ConfigItems

$OS = Get-CimInstance Win32_OperatingSystem
$compinf = Get-ComputerInfo
$loc = Get-WinSystemLocale
$IP = Get-NetIpAddress | Where-Object {($_.AddressFamily -eq 'IPv4')-and ($_.InterfaceAlias -eq 'Ethernet')}
$IPconf = Get-NetIpConfiguration
$DNSServ = Get-DnsClientServerAddress 
$FW = Get-NetFirewallProfile
$ProcessFile = 'C:\Users\Administrator\Documents\RunningProcesses.txt'
$IEVersion = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Internet Explorer').Version
$DateTime = Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters' 
$vols = Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' -and -not [string]::IsNullOrEmpty($_.DriveLetter)}

Describe 'Generic System Integration Tests' {
	
	Context 'SIT tests - Operating System' {
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

	Context 'SIT tests  - Windows Server' {
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

	Context 'SIT tests  - Locale Settings' {
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

	Context 'SIT tests  - Host Details' {
		It 'Hostname is as expected' {
			$compinf.CsName | Should Be $expectedValues.Host.Name
		}

		It 'Computer should be joined to a domain' {
			$compinf.CsPartOfDomain | Should Be $expectedValues.Host.PartofDomain
		}

		It 'Domain role is as expected' {
			$compinf.CsDomainRole | Should Be $expectedValues.Host.DomainRole
		}	
	}

	Context 'SIT tests  - Network Configuration' {
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
           	 $Results = $DNSServ.ServerAddresses
             $Results[0] | Should Be $expectedValues.NetworkConfig.DNS.Server1
             $Results[1] | Should Be $expectedValues.NetworkConfig.DNS.Server2 
		}
	}

	Context 'SIT tests  - Lockdown' {
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

	Context 'SIT tests  - Check Installed Software Versions' {
		    It " Internet Explorer version is as expected " {
            		$IEVersion | Should Be $expectedValues.SoftwareVers.InternetExplorer
            	}
	}

	Context 'SIT tests  - Check File System and Disk Configuration' {
		   $vols | ForEach-Object {
                It "Volume [$($_.DriveLetter)] file system type is as expected" {
                    $_.FileSystemType | Should Be $expectedValues.DiskConfig.FileSystemType 
                }
            }
	}

    	Context 'SIT tests  - Check Date and Time is synchronised' {
                 It 'Date and Time should be synchronised from the domain hierarchy' {
                 $DateTime = Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters' 
                 $DateTime.Type | Should Be 'AllSync'
            }
    	}
 
	Context 'SIT tests   - Services' {
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

	Context 'SIT tests  - Processes' {
		Get-Process | Out-File $ProcessFile
        	$RunningProcess | ForEach-Object {
		    It "[$_] should be running" {
            		$ProcessFile | Should Contain $_
            	        }
		}
	}
}
