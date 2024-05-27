<#
	.NOTES
=========================================================================
		Created on: 23/03/2021
		Created by: Tony Law
		Filename:   DC_SIT.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute the system integration level tests of a Windows Server, witht the Active Directory Domain Services Role installed.
		It should be run following the configuration of the domain controller.
		Note the following:
        	This script should be run with json files containing the expected values for specific servers - 
		see the $jsonPath and $expectedValues variables.
        	The file paths should be changed where necessary.
#>

param(
$DCServices = @('adws','kdc','netlogon','dns','dfsr','IsmServ','NTDS'),
$RunningService = @('BrokerInfrastructure','BFE','EventSystem','CryptSvc','DcomLaunch','Dhcp','DPS','TrkWks','Dnscache','gpsvc',
'LSM','NlaSvc','nsi','PlugPlay','SamSs','LanmanServer','SENS','SystemEventsBroker','Schedule','lmhosts','TimeBrokerSvc',
'UALSVC','UserManager','ProfSvc','WdNisSvc','WinDefend','EventLog','MpsSvc','Winmgmt','WinRM','W32Time'),
$StoppedService = @('bthserv','icssvc','PhoneSvc','WalletService'),
$RunningProcess = @('conhost','csrss','dwm','explorer','Idle','LogonUI','lsass','MsMpEng','NisSrv','rdpclip','RuntimeBroker',
'services','ShellExperienceHost','sihost','smss','svchost','System','spoolsv','taskhostw','wininit','winlogon','WmiPrvSE')
)

$jsonPath = 'C:\WkDir\jsonfile.json'
$expectedValues = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).ConfigItems

$Feature = Get-WindowsFeature AD-Domain-Services
$domainrole = Get-CimInstance -Class Win32_computersystem -ComputerName $env:computername
$DC = Get-ADDomainController
$Domain = Get-ADDomain
$Forest = Get-ADForest
$sysvol = 'C:\Windows\SYSVOL\sysvol'
$NTDS = 'C:\Windows\NTDS'
$NTDSFile = 'C:\WkDir\NTDSFiles.txt'

$OS = Get-CimInstance Win32_OperatingSystem
$compinf = Get-ComputerInfo
$loc = Get-WinSystemLocale
$IP = Get-NetIpAddress | Where-Object {($_.AddressFamily -eq 'IPv4')-and ($_.InterfaceAlias -eq 'Ethernet')}
$IPconf = Get-NetIpConfiguration
$FW = Get-NetFirewallProfile
$ProcessFile = 'C:\WkDir\RunningProcesses.txt'

Describe 'Domain controller system integration tests' {
	Context 'DC tests' {
		It 'AD DS role is installed' {
			$Feature.InstallState | Should Be 'Installed'
		}

		It 'Domain role is as expected' {
			$domainrole.domainrole | Should Be $expectedValues.DC.DomainRole
		}

		It 'Global catalog status is as expected' { 
			$DC.IsGlobalCatalog | Should Be $expectedValues.DC.GlobalCatalogStatus
		}

		$DCServices | ForEach-Object {
        	It "[$_] should be running" {
                	(Get-Service $_).Status | Should Be 'Running'
                }
		}

		It 'Domain is as expected' {
			$Domain.Name | Should Be $expectedValues.DC.DomainName
		}

		It 'Forest is as expected' {
			$Domain.Forest | Should Be $expectedValues.DC.Forest
		}

		It 'Ownership of domain roles is as expected' {
			$Domain.InfrastructureMaster | Should Be $expectedValues.DC.InfrastructureMaster
			$Domain.RIDMaster | Should Be $expectedValues.DC.RIDMaster
			$Domain.PDCEmulator | Should Be $expectedValues.DC.PDCEmulator
		}
	
		It 'Ownership of forest roles is as expected' {
			$Forest.DomainNamingMaster | Should Be $expectedValues.DC.DomainNamingMaster
			$Forest.SchemaMaster | Should Be $expectedValues.DC.SchemaMaster
		}

		It 'Domain mode is as expected' {
			$Domain.DomainMode | Should Be $expectedValues.DC.DomainMode
		}

		It 'Forest mode is as expected' {
			$Forest.ForestMode | Should Be $expectedValues.DC.ForestMode
		}

		It 'Sysvol share should exist' {
			Test-Path $sysvol | Should Be 'True'
		}

		It 'Default domain controller OU should be created' {
			$Domain.DomainControllersContainer | Should Be $expectedValues.DC.DCOU
		}

		It 'NTDS database directory should exist' {
			Test-Path $NTDS | Should Be 'True'
		}

		It 'NTDS database should contain log files' {
        		Get-ChildItem $NTDS | Select Name | Out-File $NTDSFile
       			$NTDSFile | Should Contain '.log'
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

	Context 'Regression tests - Host Details' {
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