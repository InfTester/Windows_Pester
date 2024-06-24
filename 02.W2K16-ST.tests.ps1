<#
	.NOTES
=========================================================================
		Created on: 09/03/2021
		Created by: Tony Law
		Filename:   Generic-BaseBuildSystemTests.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute the system level tests of a Windows Server base build, that is, 
		before the server has been joined to a domain and any further configuration applied. It should be run 
		following the successful execution of the BVT.
		Note the following:
        This script should be run with json files containing the expected values for specific servers - 
		see the $jsonPath and $expectedValues variables.
        The $file variable should be changed to an appropriate path.
		The services and processes listed in the param block may need to be edited depending on the server
		the script is being run against.
#>

param(
$RunningService = @('BrokerInfrastructure','BFE','EventSystem','CryptSvc','DcomLaunch','Dhcp','DPS','TrkWks','Dnscache','gpsvc',
'LSM','NlaSvc','nsi','PlugPlay','PcaSvc','SamSs','LanmanServer','SENS','SystemEventsBroker','Schedule','lmhosts','TimeBrokerSvc',
'UALSVC','UserManager','ProfSvc','WdNisSvc','WinDefend','EventLog','MpsSvc','Winmgmt','WinRM','W32Time'),
$StoppedService = @('bthserv','icssvc','PhoneSvc','WalletService'),
$RunningProcess = @('conhost','csrss','dwm','explorer','Idle','LogonUI','lsass','MpCmdRun','MsMpEng','NisSrv','rdpclip','RuntimeBroker',
'services','ShellExperienceHost','sihost','smss','svchost','System','spoolsv','taskhostw','wininit','winlogon','WmiPrvSE')
)
$jsonPath = 'C:\Users\Administrator\Documents\W2019-BaseBuildSystemTests-i-023057113bf97782d.json'
$expectedValues = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).ConfigItems
$OS = Get-CimInstance Win32_OperatingSystem
$compinf = Get-ComputerInfo
$loc = Get-WinSystemLocale
$IP = Get-NetIpAddress | Where-Object {($_.AddressFamily -eq 'IPv4')-and ($_.InterfaceAlias -eq 'Ethernet')}
$IPconf = Get-NetIpConfiguration
$DHCP = Get-NetIPInterface | Where-Object {($_.AddressFamily -eq 'IPv4')-and ($_.InterfaceAlias -eq 'Ethernet')}
$FW = Get-NetFirewallProfile
$PagingFile = Get-CimInstance Win32_PageFileUsage


Describe 'Windows Server 2019 System Tests' {
	Context 'Operating System' {
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

	Context 'Windows Server' {
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

	Context 'Locale Settings' {
		It 'Locale name is as expected' {
			$loc.Name | Should Be $expectedValues.Locale.Name
		}

		It 'Locale display name is as expected' {
			$loc.DisplayName | Should Be $expectedValues.Locale.DisplayName
		}

		It 'System language code is as expected' {
			$loc.LCID | Should Be $expectedValues.Locale.LCID
		}

		It 'Keyboard layout is as expected' {
			$compinf.KeyboardLayout | Should Be $expectedValues.Locale.Keyboard
		}

		It 'Timezone is as expected' {
			$compinf.TimeZone | Should Be $expectedValues.Locale.TimeZone
		}
	}

	Context 'Host Details' {
		It 'Hostname is as expected' {
			$compinf.CsName | Should Be $expectedValues.Host.Name
		}

		It 'Domain is as expected' {
			$compinf.CsDomain | Should Be $expectedValues.Host.Domain
		}

		It 'Computer should not be joined to a domain' {
			$compinf.CsPartOfDomain | Should Be $expectedValues.Host.PartofDomain
		}

		It 'Domain role is as expected' {
			$compinf.CsDomainRole | Should Be $expectedValues.Host.DomainRole
		}
	}

	Context 'Network Configuration' {
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
        
        It 'DHCP should be enabled' {
            $DHCP.Dhcp | Should Be 'Enabled'
        }
	}

	Context 'Lockdown' {
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

		It 'BIOS version is as expected' {
			$compinf.BiosVersion | Should Be $expectedValues.BIOS.Version
		}

		It 'BIOS name is as expected' {
			$compinf.BiosName | Should Be $expectedValues.BIOS.Name
		}

        It 'BIOS description is as expected' {
            $compinf.BiosDescription | Should Be $expectedValues.BIOS.Description
		}

		It 'BIOS firmware type is as expected' {
			$compinf.BiosFirmwareType | Should Be $expectedValues.BIOS.Firmware
		}

		It 'BIOS status should be OK' {
			$compinf.BiosStatus | Should Be 'OK'
		}

		It 'BIOS software element state should be running' {
			$compinf.BiosSoftwareElementState | Should Be 'Running'
		}

		It 'SMBIOS should be present' {
			$compinf.BiosSMBIOSPresent | Should Be 'True'
		}

        It 'SMBIOS version is as expected' {
            $compinf.BiosSMBIOSBIOSVersion | Should Be $expectedValues.BIOS.SMBIOSVersion
		}
	}

    Context 'Hardware Specifications' {
		It 'Total physical memory should be greater than 1900000' {
			$OS.TotalVisibleMemorySize | Should BeGreaterThan '1900000'
		}

		It 'Total physical memory should be less than 2100000' {
			$OS.TotalVisibleMemorySize | Should BeLessThan '2100000'
		}
	}

	Context 'Pagefile' {
		It 'Pagefile file path should be C:\pagefile.sys' {
			$compinf.OsPagingFiles | Should Be 'C:\pagefile.sys'
		}

		It 'Total size stored in paging files should be greater than 250000' {
			$OS.SizeStoredInpagingFiles | Should BeGreaterThan '250000'
		}

		It 'Total size stored in paging files should be less than 2000000' {
			$OS.SizeStoredInpagingFiles | Should BeLessThan '2000000'
		}

        It 'Current paging file usage should be less than 200' {
            $PagingFile.CurrentUsage | Should BeLessThan '200'
		}
	}

	Context 'Services' {
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

	Context 'Processes' {
		$File = 'C:\Users\Administrator\Documents\RunningProcesses.txt'
		Get-Process | Out-File $File
        	$RunningProcess | ForEach-Object {
		    It "[$_] should be running" {
            		$File | Should Contain $_
            	}
		}
	}
}