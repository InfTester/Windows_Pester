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

    It "WindowsProductId:  00326-00864-26372-AAOEM" {
        $con.WindowsProductId | Should -Be "00326-00864-26372-AAOEM"
    }

    It "WindowsProductName: It Windows 10 Home" {
        $con.WindowsProductName | Should -Be "Windows 10 Home"
    }
    
    It "WindowsRegisteredOrganization:  null" {
          
        $con.WindowsRegisteredOrganization| Should -Be $null
    }

    It "WindowsRegisteredOwner: null" {
          
        $con.WindowsRegisteredOwner | Should -Be $null
          
}
   It "WindowsSystemRoot:  C:\\WINDOWS" {
    
        $con.WindowsSystemRoot | Should -Be C:\WINDOWS
          
}

   It "WindowsVersion: 2004" {
    
        $con.WindowsVersion | Should -Be 2004
          
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

    It "BiosCurrentLanguage:  en|US|iso8859-1" {    
              $con.BiosCurrentLanguage | Should -Be "en|US|iso8859-1"       
    }

   
    It "BiosEmbeddedControllerMajorVersion:  255" { 
              $con.BiosEmbeddedControllerMajorVersion | Should -Be 255        
    }

    It "BiosEmbeddedControllerMinorVersion:  255" {
              $con.BiosEmbeddedControllerMinorVersion | Should -Be 255        
    }

    It "BiosFirmwareType:  1" {
              $con.BiosFirmwareType | Should -Be 1  
    }

    It "BiosIdentificationCode:  null" {
          
              $con.BiosIdentificationCode | Should -Be $null     
    }

    It "BiosInstallableLanguages:  9" {
          
              $con.BiosInstallableLanguages | Should -Be 9
    }

    It "BiosInstallDate:  null" {
          
              $con.BiosInstallDate | Should -Be $null
                
    }
    It "BiosLanguageEdition:  null" {          
              $con.BiosLanguageEdition | Should -Be $null
                
    }
<#
    It "BiosListOfLanguages: en|US|iso8859-1,fr|FR|iso8859-1,zh|TW|unicode,ja|JP|unicode,de|DE|iso8859-1,es|ES|iso8859-1,ru|RU|iso8859-5,ko|KR|unicode" {
                        $con.BiosListOfLanguage | Should -Be "[en|US|iso8859-1,fr|FR|iso8859-1,zh|TW|unicode,ja|JP|unicode,de|DE|iso8859-1,es|ES|iso8859-1,ru|RU|iso8859-5,ko|KR|unicode,]"
    }
#>
 
    It "BiosManufacturer:  American Megatrends Inc." {
          
              $con.BiosManufacturer | Should -Be "American Megatrends Inc."           
    }


    It "BiosName:  It Bios Date: 11/13/19 17:18:20 Ver: 05.0000D "{
                        $con.BiosName | Should -Be "Bios Date: 11/13/19 17:18:20 Ver: 05.0000D"
    }
#>
<#
    It "BiosOtherTargetOS:  null" {
                        $con.BiosOtherTargetOS | Should -Be $null                
    }

    It "BiosPrimaryBIOS:  true" {          
            $con.BiosPrimaryBIOS | Should -Be $true                
    }

It "BiosReleaseDate:  \/Date(1573603200000)\/" {
          
              $con.BiosReleaseDate | Should -Be \/Date(1573603200000)\/
                
    }

It "BiosSeralNumber:  AS00000006745" {          
              $con.BiosSeralNumber | Should -Be AS00000006745                
    }

It "BiosSMBIOSBIOSVersion:  2006" {          
              $con.BiosSMBIOSBIOSVersion | Should -Be 2006                
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

It "BiosSystemBiosMajorVersion:  5" {          
              $con.BiosSystemBiosMajorVersion | Should -Be 5                
    }

It "BiosSystemBiosMinorVersion:  13" {          
              $con.BiosSystemBiosMinorVersion | Should -Be 13                
    }

It "BiosTargetOperatingSystem:  0" {          
              $con.BiosTargetOperatingSystem | Should -Be 0                
    }

It "BiosVersion:  ALASKA - 1072009" {          
              $con.BiosVersion | Should -Be ALASKA - 1072009                
    }

It "CsAdminPasswordStatus:  3" {          
              $con.CsAdminPasswordStatus | Should -Be 3                
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
              $con.CsBootupState | Should -Be          
    }

It "CsCaption:  DESKTOP-0NI678D" {
              $con.CsCaption | Should -Be DESKTOP-0NI678D        
    }

It "CsChassisBootupState:  3" {
              $con.CsChassisBootupState | Should -Be 3       
    }

It "CsChassisSKUNumber:  Default string" {  
              $con.CsChassisSKUNumber | Should -Be    
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
It "CsDNSHostName:  DESKTOP-0NI678D" {          
              $con.CsDNSHostName | Should -Be "DESKTOP-0NI678D"
                
    }
It "CsDomain:  WORKGROUP" {
              $con.CsDomain | Should -Be WORKGROUP
                
    }
It "CsDomainRole:  0" {
               $con.CsDomainRole | Should -Be 0
                
    }
It "CsEnableDaylightSavingsTime:  true" {
               $con.CsEnableDaylightSavingsTime | Should -Be $true
                
    }
It "CsFrontPanelResetStatus:  3" {
              $con.CsFrontPanelResetStatus | Should -Be 3
                
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
              $con.CsKeyboardPasswordStatus | Should -Be 3
                
    }
It "CsLastLoadInfo:  null" {          
              $con.CsLastLoadInfo| Should -Be $null                
    }
It "CsManufacturer:  AlphaSync" {          
              $con.CsManufacturer | Should -Be AlphaSync                
    }
It "CsModel:  System Product Name" {          
              $con.CsModel | Should -Be "System Product Name"                
    }

    It "CsName:  DESKTOP-0NI678D" {          
              $con.CsName | Should -Be "DESKTOP-0NI678D"                
    }

    It "CsNetworkAdapters:" "Description:"  "Realtek RTL8192EE Wireless LAN 802.11n PCI-E NIC" {
        $con.CsNetworkAdapters.Description | Should -Be "Realtek RTL8192EE Wireless LAN 802.11n PCI-E NIC"
    }
 
    It "CsNetworkAdapters: ConnectionID:  WiFi" {
        $con.CsNetworkAdapters.ConnectionID | Should -Be "WiFi"  
    }

    It "CsNetworkAdapters:" "DHCPEnabled:"  "null" 
        $con.CsNetworkAdapters.DHCPEnabled | Should -Be $null
    }   

    It "CsNetworkAdapters: DHCPServer: null" {
        $con.CsNetworkAdapters.DHCPServer | Should -Be $null
    }   

    It "CsNetworkAdapters:" "DHCPEnabled:"  "null" {
        $con.CsNetworkAdapters.ConnectionStatus | Should -Be 
    }   

It "CsNetworkAdapters:" "DHCPEnabled:"  "null" {
$con.CsNetworkAdapters.IPAddresses | Should -Be $null
    }   

$con.ConnectionID | Should -Be "WiFi" {
                
    }
                              {
                                  "Description:  "Realtek PCIe GbE Family Controller",
                                  "ConnectionID:  "Ethernet",
                                  "DHCPEnabled:  true,
                                  "DHCPServer:  "192.168.1.254",
                                  "ConnectionStatus:  2,
                                  "IPAddresses:  "192.168.1.136 fe80::c57a:7fe8:b72b:2673 2a00:23c7:69a6:9a01:fd06:ef05:e826:fdb5 2a00:23c7:69a6:9a01:f538:9dc0:c0c0:4f13 2a00:23c7:69a6:9a01:d157:1fc0:fc03:a1c7 2a00:23c7:69a6:9a01:6014:c3f1:26ef:4869 2a00:23c7:69a6:9a01:1423:927e:8188:9c93 2a00:23c7:69a6:9a01:c57a:7fe8:b72b:2673"
#>
}
