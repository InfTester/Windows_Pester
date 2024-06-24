$con = Get-ComputerInfo
Describe 'Validate that the desktop configuration is correct' {
    It "WindowsCurrentVersion:  6.3" {
        $con.WindowsCurrentVersion| Should -Be "6.3"
    }

    It "WindowsEditionId:  Core" {
        $con.WindowsEditionId | Should -Be "Core"
    }

    It "WindowsInstallationType: Client" {
        $con.WindowsInstallationType | Should -Be "Client"
    }

    It "WindowsProductId:  00325-80268-58582-AAOEM" {
        $con.WindowsProductId | Should -Be "00325-80268-58582-AAOEM"
    }

    It "WindowsProductName: It Windows 10 Home" {
        $con.WindowsProductName | Should -Be "Windows 10 Home"
    }
    
    It "WindowsRe
    isteredOrganization:  Hewlett-Packard" {
          
        $con.WindowsRegisteredOrganization| Should -Be Hewlett-Packard
    }

    It "WindowsRegisteredOwner: tonylaw35@hotmail.com" {
          
        $con.WindowsRegisteredOwner | Should -Be tonylaw35@hotmail.com
          
}
   It "WindowsSystemRoot:  C:\\WINDOWS" {
    
        $con.WindowsSystemRoot | Should -Be C:\WINDOWS
          
}

   It "WindowsVersion: 1903" {
    
        $con.WindowsVersion | Should -Be 1903
          
}

<#
    It "BiosBIOSVersion: ALASKA - 1072009, BIOS Date: 11/13/19 17:18:20 Ver: 05.0000D" {

        $con.BiosBIOSVersion | Should -Be "BiosBIOSVersion: ALASKA - 1072009, BIOS Date: 11/13/19 17:18:20 Ver: 05.0000D"
          
}
#>

    It "BiosBuildNumber:  null" {          
              $con.BiosBuildNumber| Should -Be $null       
    }

    It "BiosCodeSet:  null" {
              $con.BiosCodeSet | Should -Be $null        
    }

    It "BiosCurrentLanguage:  en|US|iso8859-1,0" {    
              $con.BiosCurrentLanguage | Should -Be "en|US|iso8859-1,0"       
    }

   
    It "BiosEmbeddedControllerMajorVersion:  67" { 
              $con.BiosEmbeddedControllerMajorVersion | Should -Be 87     
    }

    It "BiosEmbeddedControllerMinorVersion:  39" {
              $con.BiosEmbeddedControllerMinorVersion | Should -Be 39      
    }

    It "BiosFirmwareType:  Uefi" {
              $con.BiosFirmwareType | Should -Be Uefi  
    }

    It "BiosIdentificationCode:  null" {
          
              $con.BiosIdentificationCode | Should -Be $null     
    }

    It "BiosInstallableLanguages:  5" {
          
              $con.BiosInstallableLanguages | Should -Be 5
    }

    It "BiosInstallDate:  null" {
          
              $con.BiosInstallDate | Should -Be $null
                
    }
    It "BiosLanguageEdition:  null" {          
              $con.BiosLanguageEdition | Should -Be $null
                
    }

    It "BiosListOfLanguages: en|US|iso8859-1,fr|FR|iso8859-1,zh|TW|unicode,ja|JP|unicode,de|DE|iso8859-1,es|ES|iso8859-1,ru|RU|iso8859-5,ko|KR|unicode" {
                        $con.BiosListOfLanguages[0] | Should -Be "en|US|iso8859-1,0"
    }
    It "BiosListOfLanguages: en|US|iso8859-1,fr|FR|iso8859-1,zh|TW|unicode,ja|JP|unicode,de|DE|iso8859-1,es|ES|iso8859-1,ru|RU|iso8859-5,ko|KR|unicode" {
                        $con.BiosListOfLanguages[1] | Should -Be "fr|FR|iso8859-1,0"
    }
    It "BiosListOfLanguages: en|US|iso8859-1,fr|FR|iso8859-1,zh|TW|unicode,ja|JP|unicode,de|DE|iso8859-1,es|ES|iso8859-1,ru|RU|iso8859-5,ko|KR|unicode" {
                        $con.BiosListOfLanguages[2] | Should -Be "es|ES|iso8859-1,0"
    }
 It "BiosListOfLanguages: en|US|iso8859-1,fr|FR|iso8859-1,zh|TW|unicode,ja|JP|unicode,de|DE|iso8859-1,es|ES|iso8859-1,ru|RU|iso8859-5,ko|KR|unicode" {
                        $con.BiosListOfLanguages[3] | Should -Be "zh|TW|unicode,0"
    }
    It "BiosListOfLanguages: en|US|iso8859-1,fr|FR|iso8859-1,zh|TW|unicode,ja|JP|unicode,de|DE|iso8859-1,es|ES|iso8859-1,ru|RU|iso8859-5,ko|KR|unicode" {
                        $con.BiosListOfLanguages[4] | Should -Be "zh|CN|unicode,0"
    }
    It "BiosManufacturer:  Insyde" {
          
              $con.BiosManufacturer | Should -Be "Insyde"           
    }


    It "BiosName:  It Bios Date: 11/13/19 17:18:20 Ver: 05.0000D "{
                        $con.BiosName | Should -Be "F.19"
    }

    It "BiosOtherTargetOS:  null" {
                        $con.BiosOtherTargetOS | Should -Be $null                
    }

    It "BiosPrimaryBIOS:  true" {          
            $con.BiosPrimaryBIOS | Should -Be $true                
    }

#It "BiosReleaseDate:  \/Date(1573603200000)\/" {
 #         
    #          $con.BiosReleaseDate | Should -BeLike "2015-09-15"
                
 #   }

It "BiosSeralNumber:  CND5401QPX" {          
              $con.BiosSeralNumber | Should -Be CND5401QPX                
    }

It "BiosSMBIOSBIOSVersion:  F.19" {          
              $con.BiosSMBIOSBIOSVersion | Should -Be F.19                
    }

It "BiosSMBIOSMajorVersion:  2" {          
              $con.BiosSMBIOSMajorVersion | Should -Be 2                
    }

It "BiosSMBIOSMinorVersion:  8" {          
              $con.BiosSMBIOSMinorVersion | Should -Be 8                
    }

It "BiosSMBIOSPresent:  true" {          
              $con.BiosSMBIOSPresent | Should -Be true                
    }

It "BiosSoftwareElementState:  3" {          
              $con.BiosSoftwareElementState | Should -Be 3                
    }

It "BiosStatus:  OK" {          
              $con.BiosStatus | Should -Be OK                
    }

It "BiosSystemBiosMajorVersion:  15" {          
              $con.BiosSystemBiosMajorVersion | Should -Be 15                
    }

It "BiosSystemBiosMinorVersion:  25" {          
              $con.BiosSystemBiosMinorVersion | Should -Be 25                
    }

It "BiosTargetOperatingSystem:  0" {          
              $con.BiosTargetOperatingSystem | Should -Be 0                
    }

It "BiosVersion:  HPQOEM - 0" {          
              $con.BiosVersion | Should -Be "HPQOEM - 0"                
    }

It "CsAdminPasswordStatus:  Disabled" {          
              $con.CsAdminPasswordStatus | Should -Be Disabled                
    }

It "CsAutomaticManagedPagefile:  true" {          
              $con.CsAutomaticManagedPagefile | Should -Be $true                
    }

It "CsAutomaticResetBootOption:  true" {          
              $con.CsAutomaticResetBootOption | Should -Be $true                
    }

It "CsAutomaticResetCapability:  true" {
                        $con.CsAutomaticResetCapability | Should -Be $true      
    }

It "CsBootOptionOnLimit:  null" {
              $con.CsBootOptionOnLimit | Should -Be $null
    }
It "CsBootOptionOnWatchDog:  null" {
                        $con.CsBootOptionOnWatchDog | Should -Be $null       
    }

It "CsBootROMSupported:  true" { 
              $con.CsBootROMSupported | Should -Be $true          
    }

It "CsBootupState:  Normal boot" {    
              $con.CsBootupState | Should -Be "Normal Boot"     
    }

It "CsCaption:  DESKTOP-HHC2S8D" {
              $con.CsCaption | Should -Be DESKTOP-HHC2S8D       
    }

It "CsChassisBootupState:  3" {
              $con.CsChassisBootupState | Should -Be 3       
    }

It "CsChassisSKUNumber:  " {  
              $con.CsChassisSKUNumber | Should -Be $null 
    }

It "CsCurrentTimeZone:  0" {
              $con.CsCurrentTimeZone | Should -Be 0        
    }

It "CsDaylightInEffect:  false" {
              $con.CsDaylightInEffect | Should -Be $false   
    }

It "CsDescription:  AT/AT COMPATIBLE" {          
              $con.CsDescription | Should -Be "AT/AT COMPATIBLE"
                
    }
It "CsDNSHostName:  DESKTOP-HHC2S8D" {          
              $con.CsDNSHostName | Should -Be "DESKTOP-HHC2S8D"
                
    }
It "CsDomain:  WORKGROUP" {
              $con.CsDomain | Should -Be WORKGROUP
                
    }
It "CsDomainRole:  StandaloneWorkstation" {
               $con.CsDomainRole | Should -Be StandaloneWorkstation
                
    }
It "CsEnableDaylightSavingsTime:  true" {
               $con.CsEnableDaylightSavingsTime | Should -Be $true
                
    }
It "CsFrontPanelResetStatus:  NotImplemented" {
              $con.CsFrontPanelResetStatus | Should -Be NotImplemented
                
    }
It "CsHypervisorPresent:  false" {
              $con.CsHypervisorPresent | Should -Be $false
                
    }
It "CsInfraredSupported:  false" {          
              $con.CsInfraredSupported | Should -Be $false
                
    }
It "CsInitialLoadInfo:  null" {          
              $con.CsInitialLoadInfo | Should -Be $null
                
    }
It "CsInstallDate:  null" {          
              $con.CsInstallDate | Should -Be $null
                
    }

It "CsKeyboardPasswordStatus:  3" {          
              $con.CsKeyboardPasswordStatus | Should -Be NotImplemented              
    }

It "CsLastLoadInfo:  null" {          
              $con.CsLastLoadInfo| Should -Be $null                
    }
It "CsManufacturer:  HP" {          
              $con.CsManufacturer | Should -Be HP                
    }

It "CsModel:  HP ENVY Notebook" {          
              $con.CsModel | Should -Be "HP ENVY Notebook"                
    }

    It "CsName:  DESKTOP-HHC2S8D" {          
              $con.CsName | Should -Be "DESKTOP-HHC2S8D"                
    }
 
    It "CsNetworkAdapters Description: Intel(R) Dual Band Wireless-AC 7265" {
        $con.CsNetworkAdapters.Description | Should -Be "Intel(R) Dual Band Wireless-AC 7265"
    }

    It "CsNetworkAdapters: ConnectionID:  Wi-Fi" {
        $con.CsNetworkAdapters.ConnectionID | Should -Be "Wi-Fi"  
    }

    It "CsNetworkAdapters:DHCPEnabled: true" {
        $con.CsNetworkAdapters.DHCPEnabled | Should -Be $true
    }   

    It "CsNetworkAdapters: DHCPServer: $true" {
        $con.CsNetworkAdapters.DHCPServer | Should -Be $true
    }   

    It "CsNetworkAdapters:DHCPEnabled: Connected" {
        $con.CsNetworkAdapters.ConnectionStatus | Should -Be Connected
    }   

    It "CsNetworkAdapters:IPAdresses: 192.168.1.201" {
        $con.CsNetworkAdapters.IPAddresses[0] | Should -Be "192.168.1.201"
    }  
    It "Subnet mask is 255.255.255.0" { Get-NetIPAddress | where-Object -FilterScript { $_.InterfaceAlias -eq "Ethernet" -and $_.AddressFamily -eq "IPv4" } | Select PrefixLength | Should -Be 24 
    }

    It "CsNetworkServerModeEnabled: True" {
        $con.CsNetworkServerModeEnabled | Should -Be $True
    }
    It "CsNetworkServerModeEnabled:True"  {
        $con.CsNetworkServerModeEnabled | Should -Be True 
    }

    It "CsNumberOfLogicalProcessors:4"  { 
        $con.CsNumberOfLogicalProcessors | Should -Be 4
    }

    It "CsNumberOfProcessors:1"  { 
    $con.CsNumberOfProcessors | Should -Be 1
    }

    It "CsProcessors:{Intel(R)Core(TM)i3-6100UCPU@2.30GHz}"  { 
        $con.CsProcessors.Manufacturer | Should -Be GenuineIntel
    }
    It "CsProcessors:{Intel(R)Core(TM)i3-6100UCPU@2.30GHz}"  { 
        $con.CsProcessors.Name | Should -Be "Intel(R) Core(TM) i3-6100U CPU @ 2.30GHz" 
    }
    It "CsProcessors.Manufacturer:Intel64 Family 6 Model 78 Stepping 3" { 
        $con.CsProcessors.Description | Should -Be "Intel64 Family 6 Model 78 Stepping 3"
    }
    It "CsProcessors.Architecture:x64" { 
        $con.CsProcessors.Architecture | Should -Be x64
    }
    It "CsProcessors.AddressWidth:64" { 
        $con.CsProcessors.AddressWidth | Should -Be 64
    }
    It "CsProcessors.DataWidth:64" { 
        $con.CsProcessors.DataWidth | Should -Be 64
    }
    It "CsProcessors.MaxClockSpeed:2301" { 
        $con.CsProcessors.MaxClockSpeed | Should -Be 2301
    }
    It "CsProcessors.CurrentClockSpeed:400" { 
        $con.CsProcessors.CurrentClockSpeed | Should -BeLessThan 2000
    }
    It "CsProcessors.NumberOfCores:2" { 
        $con.CsProcessors.NumberOfCores | Should -Be 2
    }
    It "CsProcessors.NumberOfLogicalProcessors:4" { 
        $con.CsProcessors.NumberOfLogicalProcessors | Should -Be 4
    }
    It "CsProcessors.ProcessorID:BFEBFBFF000406E3" { 
        $con.CsProcessors.ProcessorID | Should -Be BFEBFBFF000406E3
    }
    It "CsProcessors.SocketDesignation:U3E1" { 
        $con.CsProcessors.SocketDesignation | Should -Be U3E1
    }
    It "CsProcessors.ProcessorType:CentralProcessor" { 
        $con.CsProcessors.ProcessorType | Should -Be CentralProcessor
    }
    It "CsProcessors.Role:CPU" { 
        $con.CsProcessors.Role | Should -Be CPU
    }
    It "CsProcessors.Status:OK" { 
        $con.CsProcessors.Status | Should -Be OK
    }
    It "CsProcessors.CpuStatus:Enabled" { 
        $con.CsProcessors.CpuStatus | Should -Be Enabled
    }
    It "CsProcessors.Availability:RunningOrFullPower" { 
        $con.CsProcessors.Availability | Should -Be RunningOrFullPower
    }

    It "CsOEMStringArray:{$HP$,LOC#ABA,ABS70/7178797A7B,OemString4...}"
        {
    
        $con.CsOEMStringArray[0] | Should -Be $HP$
        }
    It "CsPartOfDomain:False"  { 
    $con.CsPartOfDomain | Should -Be False 
    }
    It "CsPauseAfterReset:-1"  { 
    $con.CsPauseAfterReset | Should -Be -1
    }
    It "CsPCSystemType:Mobile"  { 
    $con.CsPCSystemType | Should -Be Mobile 
    }
    It "CsPCSystemTypeEx:Mobile"  { 
    $con.CsPCSystemTypeEx | Should -Be Mobile
     }
    It "CsPowerManagementCapabilities:"  { 
    $con.CsPowerManagementCapabilities | Should -Be  
    }
    It "CsPowerManagementSupported:"  { 
    $con.CsPowerManagementSupported | Should -Be  }
    It "CsPowerOnPasswordStatus:NotImplemented"  { 
    $con.CsPowerOnPasswordStatus | Should -Be NotImplemented 
    }
    It "CsPowerState:Unknown"  { 
    $con.CsPowerState | Should -Be Unknown 
    }
    It "CsPowerSupplyState:Safe"  { $con.CsPowerSupplyState | Should -Be Safe 
    }
    It "CsPrimaryOwnerContact:"  { $con.CsPrimaryOwnerContact | Should -Be  
    }
    It "CsPrimaryOwnerName:tonylaw35@hotmail.com"  { $con.CsPrimaryOwnerName | Should -Be tonylaw35@hotmail.com 
    }
    It "CsResetCapability:Other"  { $con.CsResetCapability | Should -Be Other 
    }
    It "CsResetCount:-1"  { $con.CsResetCount | Should -Be -1
    }
    It "CsResetLimit:-1"  { $con.CsResetLimit | Should -Be -1
    }
    It "CsRoles:{LM_Workstation,LM_Server,NT}"  { $con.CsRoles[0] | Should -Be LM_Workstation
    }
    It "CsRoles:{LM_Workstation,LM_Server,NT}"  { $con.CsRoles[1] | Should -Be LM_Server
    }
     It "CsRoles:{LM_Workstation,LM_Server,NT}"  { $con.CsRoles[2] | Should -Be NT 
    }
    It "CsStatus:OK"  { $con.CsStatus | Should -Be OK 
    }
    It "CsSupportContactDescription:"  { $con.CsSupportContactDescription | Should -Be  
    }
    #It "CsSystemFamily:103C_5335KVG=NL=CONB=HPS=ENV"  { $con.CsSystemFamily | Should -Be "103C_5335KV G=N L=CON B=HP S=ENV"
    #}
    It "CsSystemSKUNumber:N9S66EA#ABU"  { $con.CsSystemSKUNumber | Should -Be N9S66EA#ABU 
    }
    It "CsSystemType:x64-basedPC"  { $con.CsSystemType | Should -Be "x64-based PC"
    }
    It "CsThermalState:Safe"  { $con.CsThermalState | Should -Be Safe 
    }
    It "CsTotalPhysicalMemory:4188438528"  { $con.CsTotalPhysicalMemory | Should -Be 4188438528
    }
    It "CsPhyicallyInstalledMemory:4194304"  { $con.CsPhyicallyInstalledMemory | Should -Be 4194304
    }
    It "CsUserName:DESKTOP-HHC2S8D\tonyl"  { $con.CsUserName | Should -Be DESKTOP-HHC2S8D\tonyl 
    }
    It "CsWakeUpType:PowerSwitch"  { $con.CsWakeUpType | Should -Be PowerSwitch 
    }
    It "CsWorkgroup:WORKGROUP"  { $con.CsWorkgroup | Should -Be WORKGROUP 
    }
    It "OsName:MicrosoftWindows10Home"  { $con.OsName | Should -Be "Microsoft Windows 10 Home" 
    }
    It "OsType:WINNT"  { $con.OsType | Should -Be WINNT }
    It "OsOperatingSystemSKU:WindowsHome"  { $con.OsOperatingSystemSKU | Should -Be WindowsHome 
    }
    It "OsVersion:10.0.18362"  {
    $con.OsVersion | Should -Be "10.0.18362"
    }
    It "OsCSDVersion:"  {
    $con.OsCSDVersion | Should -Be $null
    }
    It "OsBuildNumber:18362"  {
    $con.OsBuildNumber | Should -Be 18362
    }
    It "OsHotFixes:{KB4578974,KB4497727,KB4537759,KB4552152...}"  { $con.OsHotFixes[0].HotfixID | Should -Be KB4578974
    }
    It "OsHotFixes:{KB4578974,KB4497727,KB4537759,KB4552152...}"  { $con.OsHotFixes[1].HotfixID | Should -Be KB4497727
    }
    It "OsHotFixes:{KB4578974,KB4497727,KB4537759,KB4552152...}"  { $con.OsHotFixes[2].HotfixID | Should -Be KB4537759
    }
    It "OsHotFixes:{KB4578974,KB4497727,KB4537759,KB4552152...}"  { $con.OsHotFixes[3].HotfixID | Should -Be KB4552152
    }
    It "OsBootDevice:\Device\HarddiskVolume1"  { $con.OsBootDevice | Should -Be "\Device\HarddiskVolume1" }
    It "OsSystemDevice:\Device\HarddiskVolume3"  { $con.OsSystemDevice | Should -Be "\Device\HarddiskVolume3" }
    It "OsSystemDirectory:C:\WINDOWS\system32"  { $con.OsSystemDirectory | Should -Be "C:\WINDOWS\system32" }
    It "OsSystemDrive:C:"  { $con.OsSystemDrive | Should -Be C: }
    It "OsWindowsDirectory:C:\WINDOWS"  { $con.OsWindowsDirectory | Should -Be C:\WINDOWS }
    It "OsCountryCode:44"  { $con.OsCountryCode | Should -Be 44}
    It "OsCurrentTimeZone:0"  { $con.OsCurrentTimeZone | Should -Be 0}
    It "OsLocaleID:0809"  { $con.OsLocaleID | Should -Be 809}
    It "OsLocale:en-GB"  { $con.OsLocale | Should -Be en-GB }
    #It "OsLocalDateTime:07/11/202011:21:33"  { $con.OsLocalDateTime | Should -Be "07/11/202011:21:33"
    #}
    #It "OsLastBootUpTime:26/10/202019:38:10"  { $con.OsLastBootUpTime | Should -Be 26/10/202019:38:10 }
    It "OsUptime:11.15:43:23.0399350"  { $con.OsUptime | Should -BeLessThan 20000000 }
    
    It "OsBuildType:MultiprocessorFree"  { $con.OsBuildType | Should -Be "Multiprocessor Free" }
    It "OsCodeSet:1252"  { $con.OsCodeSet | Should -Be 1252}
    It "OsDataExecutionPreventionAvailable:True"  { $gcon.OsDataExecutionPreventionAvailable | Should -Be True }
    It "OsDataExecutionPrevention32BitApplications:True"  { $con.OsDataExecutionPrevention32BitApplications | Should -Be True }
    It "OsDataExecutionPreventionDrivers:True"  { $con.OsDataExecutionPreventionDrivers | Should -Be True }
    It "OsDataExecutionPreventionSupportPolicy:OptIn"  { $con.OsDataExecutionPreventionSupportPolicy | Should -Be OptIn }
    It "OsDebug:False"  { $con.OsDebug | Should -Be False }
    It "OsDistributed:False"  { $con.OsDistributed | Should -Be False }
    It "OsEncryptionLevel:256"  { $con.OsEncryptionLevel | Should -Be 256}
    It "OsForegroundApplicationBoost:Maximum"  { $con.OsForegroundApplicationBoost | Should -Be Maximum }
    It "OsTotalVisibleMemorySize:4090272"  { $con.OsTotalVisibleMemorySize | Should -Be 4090272}
    It "OsFreePhysicalMemory:490624"  { $con.OsFreePhysicalMemory | Should -BeGreaterThan 390624}
    It "OsTotalVirtualMemorySize:13527456"  { $con.OsTotalVirtualMemorySize | Should -Be 13527456}
    It "OsFreeVirtualMemory:6443316"  { $con.OsFreeVirtualMemory | Should -BeGreaterThan 5443316}
    It "OsInUseVirtualMemory:7084140"  { $con.OsInUseVirtualMemory | Should -BeLessThan 9084140}
    It "OsTotalSwapSpaceSize:"  { $con.OsTotalSwapSpaceSize | Should -Be  }
    It "OsSizeStoredInPagingFiles:9437184"  { $con.OsSizeStoredInPagingFiles | Should -BeLessThan 9937184}
    It "OsFreeSpaceInPagingFiles:8214884"  { $con.OsFreeSpaceInPagingFiles | Should -BeGreaterThan 5214884}
    It "OsPagingFiles:{C:\pagefile.sys}"  { $con.OsPagingFiles[0] | Should -Be C:\pagefile.sys }
    It "OsHardwareAbstractionLayer:10.0.18362.752"  { $con.OsHardwareAbstractionLayer | Should -Be 10.0.18362.752 }
   <# It "OsInstallDate:18/04/202021:30:00"  { $con.OsInstallDate | Should -Be "12020-04-18T21:30:00.0000000+01:00" }
    #>
    It "OsManufacturer:MicrosoftCorporation"  { $con.OsManufacturer | Should -Be "Microsoft Corporation" }
    It "OsMaxNumberOfProcesses:4294967295"  { $con.OsMaxNumberOfProcesses | Should -Be 4294967295}
    It "OsMaxProcessMemorySize:137438953344"  { $con.OsMaxProcessMemorySize | Should -Be 137438953344}
    It "OsMuiLanguages:{en-GB}"  { $con.OsMuiLanguages[0] | Should -Be en-GB }
    It "OsNumberOfLicensedUsers:0"  { $con.OsNumberOfLicensedUsers | Should -Be 0 }
    It "OsNumberOfProcesses:280"  { $con.OsNumberOfProcesses | Should -BeLessThan 300 }
    It "OsNumberOfUsers:2"  { $con.OsNumberOfUsers | Should -Be 2 } 
    It "OsOrganization:Hewlett-Packard"  { $con.OsOrganization | Should -Be Hewlett-Packard }
    It "OsArchitecture:64-bit"  { $con.OsArchitecture | Should -Be 64-bit }
    It "OsLanguage:en-GB"  { $con.OsLanguage | Should -Be en-GB }
    It "OsProductSuites:{TerminalServicesSingleSession,HomeEdition}"  { $con.OsProductSuites[0] | Should -Be TerminalServicesSingleSession }
    It "OsProductSuites:{TerminalServicesSingleSession,HomeEdition}"  { $con.OsProductSuites[1] | Should -Be HomeEdition }
    It "OsOtherTypeDescription:"  { $con.OsOtherTypeDescription | Should -Be  }
    It "OsPAEEnabled:"  { $con.OsPAEEnabled | Should -Be  }
    It "OsPortableOperatingSystem:False"  { $con.OsPortableOperatingSystem | Should -Be False }
    It "OsPrimary:True"  { $con.OsPrimary | Should -Be True }
    It "OsProductType:WorkStation"  { $con.OsProductType | Should -Be WorkStation }
    It "OsRegisteredUser:tonylaw35@hotmail.com"  { $con.OsRegisteredUser | Should -Be tonylaw35@hotmail.com }
    It "OsSerialNumber:00325-80268-58582-AAOEM"  { $con.OsSerialNumber | Should -Be 00325-80268-58582-AAOEM }
    It "OsServicePackMajorVersion:0"  { $con.OsServicePackMajorVersion | Should -Be 0}
    It "OsServicePackMinorVersion:0"  { $con.OsServicePackMinorVersion | Should -Be 0}
    It "OsStatus:OK"  { $con.OsStatus | Should -Be OK }
    It "OsSuites:{TerminalServices,TerminalServicesSingleSession,HomeEdition}"  { $con.OsSuites[0] | Should -Be TerminalServices }
    It "OsServerLevel:"  { $con.OsServerLevel | Should -Be  }
    It "KeyboardLayout:en-GB"  { $con.KeyboardLayout | Should -Be en-GB }
    It "TimeZone:(UTC+00:00)Dublin,Edinburgh,Lisbon,London"  { $con.TimeZone | Should -Be "(UTC+00:00) Dublin, Edinburgh, Lisbon, London" }
    It "LogonServer:\\DESKTOP-HHC2S8D"  { $con.LogonServer | Should -Be \\DESKTOP-HHC2S8D }
    It "PowerPlatformRole:Mobile"  { $con.PowerPlatformRole | Should -Be Mobile }
    It "HyperVisorPresent:False"  { $con.HyperVisorPresent | Should -Be False }
    It "HyperVRequirementDataExecutionPreventionAvailable:True"  { $con.HyperVRequirementDataExecutionPreventionAvailable | Should -Be True }
    It "HyperVRequirementSecondLevelAddressTranslation:True"  { $con.HyperVRequirementSecondLevelAddressTranslation | Should -Be True }
    It "HyperVRequirementVirtualizationFirmwareEnabled:False"  { $con.HyperVRequirementVirtualizationFirmwareEnabled | Should -Be False }
    It "HyperVRequirementVMMonitorModeExtensions:True"  { $con.HyperVRequirementVMMonitorModeExtensions | Should -Be True }
    It "DeviceGuardSmartStatus:Off"  { $con.DeviceGuardSmartStatus | Should -Be Off }
    It "DeviceGuardRequiredSecurityProperties:"  { $con.DeviceGuardRequiredSecurityProperties | Should -Be  }
    It "DeviceGuardAvailableSecurityProperties:"  { $con.DeviceGuardAvailableSecurityProperties | Should -Be  }
    It "DeviceGuardSecurityServicesConfigured:"  { $con.DeviceGuardSecurityServicesConfigured | Should -Be  }
    It "DeviceGuardSecurityServicesRunning:"  { $con.DeviceGuardSecurityServicesRunning | Should -Be  }
    It "DeviceGuardCodeIntegrityPolicyEnforcementStatus:"  { $con.DeviceGuardCodeIntegrityPolicyEnforcementStatus | Should -Be  }
    It "DeviceGuardUserModeCodeIntegrityPolicyEnforcementStatus:"  { $con.DeviceGuardUserModeCodeIntegrityPolicyEnforcementStatus | Should -Be  }


}
