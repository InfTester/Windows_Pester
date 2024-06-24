
<#
	.NOTES
=========================================================================
		Created on: 02/03/2021
		Created by: Tony Law
		Filename:   Generic-BuildVerificationTests.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute the build verification tests of a Windows Server base build, that is, 
		before the server has been joined to a domain and any further configuration applied. It should be run directly 
		following the build and prior to running the system tests. 
		Note that it should be run with json files containing the expected values for specific servers - 
		see the $jsonPath and $expectedValues variables.
#>

$jsonPath = 'C:\Users\Administrator\Documents\W2019-BuildVerificationTests-i-083964d59c9a539c1.json'
$expectedValues = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).ConfigItems
$con = Get-ComputerInfo
$vols = Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' -and -not [string]::IsNullOrEmpty($_.DriveLetter)}

Describe "WINDOWS SERVER 2019 - DOMAIN JOINED -  BUILD VERIFICATION TEST" {

    It 'Windows Build LabEx is as expected' { 
        $con.WindowsBuildLabEx | Should Be $expectedValues.WindowsBuildLabEx
    } 

    It 'Windows Current Version is as expected' { 
        $con.WindowsCurrentVersion | Should Be $expectedValues.WindowsCurrentVersion
    }

    It 'Windows Edition Id is as expected' {
        $con.WindowsEditionId | Should Be $expectedValues.WindowsEditionId
    }
     
    It 'Windows Installation Type is as expected' {
        $con.WindowsInstallationType | Should Be $expectedValues.WindowsInstallationType
    }
     
    It 'Windows Product Name is as expected' {
        $con.WindowsProductName | Should Be $expectedValues.WindowsProductName
    } 
     
    It 'Install Date is as expected' {
        $con.CsInstallDate | Should Be $expectedValues.CsInstallDate
    }

    It 'Computer Name is as expected' {
        $con.CsName | Should Be $expectedValues.CsName
    }

    It 'Network Adapters Connection ID is as expected' {
        $con.CsNetworkAdapters.ConnectionID | Should Be $expectedValues.CsNetworkAdapters.ConnectionID
    }
     
    It 'Network Adapters Description is as expected' {
        $con.CsNetworkAdapters.Description | Should Be $expectedValues.CsNetworkAdapters.Description 
    }

    It 'Network Server Mode should be enabled' {
        $con.CsNetworkServerModeEnabled | Should Be 'True'
    }
     
    It 'Number of Logical Processors is as expected' {
        $con.CsNumberOfLogicalProcessors | Should Be  $expectedValues.CsNumberOfLogicalProcessors
    }
     
    It 'Number of Processors is as expected' {
        $con.CsNumberOfProcessors | Should Be $expectedValues.CsNumberOfProcessors
    }

    It 'Processors are as expected' {
        $con.CsProcessors.Name | Should Be $expectedValues.CsProcessors.Name
    }
 
    It 'Server should not be part of a domain' {
        $con.CsPartOfDomain | Should Be  'False'
    }
     
    It 'Status should be OK' {
        $con.CsStatus | Should Be 'OK'
    }

    It 'System Type is as expected' {
        $con.CsSystemType | Should Be $expectedValues.CsSystemType
    }
     
    It 'Total Physical Memory is as expected' {
        $con.CsTotalPhysicalMemory | Should Be $expectedValues.CsTotalPhysicalMemory
    }
     
    It 'Phyically Installed Memory is as expected' {
        $con.CsPhyicallyInstalledMemory | Should Be $expectedValues.CsPhyicallyInstalledMemory
    }
 
    It 'OS Name is as expected' {
        $con.OsName | Should Be $expectedValues.OsName
    }

    It 'OS Type is as expected' {
        $con.OsType | Should Be $expectedValues.OsType
    }
     
    It 'OS Operating System SKU is as expected' {
        $con.OsOperatingSystemSKU | Should Be $expectedValues.OsOperatingSystemSKU
    } 

    It 'OS Version is as expected' {
        $con.OsVersion | Should Be $expectedValues.OsVersion
    }
     
    It 'CSD Version is as expected' {
        $con.OsCSDVersion | Should Be $expectedValues.OsCSDVersion
    }
     
    It 'OS BuildNumber is as expected' {
        $con.OsBuildNumber | Should Be $expectedValues.OsBuildNumber
    }
     
    It 'System Device is as expected' {
        $con.OsSystemDevice | Should Be $expectedValues.OsSystemDevice
    }
     
    It 'System Directory is as expected' {
        $con.OsSystemDirectory | Should Be $expectedValues.OsSystemDirectory
    }
 
    It 'System Drive is as expected' {
        $con.OsSystemDrive | Should Be $expectedValues.OsSystemDrive
    }
     
    It 'Windows Directory is as expected' {
        $con.OsWindowsDirectory | Should Be $expectedValues.OsWindowsDirectory 
    }
     
    It 'Country Code is as expected' {
        $con.OsCountryCode | Should Be $expectedValues.OsCountryCode
    }
     
    It 'Current Time Zone is as expected' {
        $con.OsCurrentTimeZone | Should Be $expectedValues.OsCurrentTimeZone
    }
     
    It 'Locale ID is as expected' {
        $con.OsLocaleID | Should Be $expectedValues.OsLocaleID
    }
     
    It 'Locale is as expected' {
        $con.OsLocale | Should Be  en-US
    }
     
    #It 'Local Date Time is as expected' {
    #   $con.OsLocalDateTime | Should Be 
    #}
     
    #It 'Last BootUp Time is as expected' {
    #   $con.OsLastBootUpTime | Should Be 
    #} 

    It 'Total Visible Memory Size is as expected' {
        $con.OsTotalVisibleMemorySize | Should Be $expectedValues.OsTotalVisibleMemorySize
    }
     
    #It 'Free Physical Memory is as expected' {
    #   $con.OsFreePhysicalMemory | Should Be 
    #}
    
    It 'Total Virtual Memory Size is as expected' {
        $con.OsTotalVirtualMemorySize | Should Be $expectedValues.OsTotalVirtualMemorySize
    } 
    
    #It 'Free Virtual Memory is as expected' {
    #   $con.OsFreeVirtualMemory | Should Be
    #}
     
    #It 'In Use Virtual Memory is as expected' {
    #   $con.OsInUseVirtualMemory   | Should Be 
    #} 
    
    It 'Install Date is as expected' {
        $con.OsInstallDate | Should Be $expectedValues.OsInstallDate
    }
     
    It 'Number of Licensed Users is as expected' {
        $con.OsNumberOfLicensedUsers | Should Be $expectedValues.OsNumberOfLicensedUsers
    } 
    
    It 'Number of Users is as expected' {
        $con.OsNumberOfUsers | Should Be $expectedValues.OsNumberOfUsers
    }
     
    It 'OS Architecture is as expected' {
        $con.OsArchitecture | Should Be $expectedValues.OsArchitecture
    }
     
    It 'OS Language is as expected' {
        $con.OsLanguage | Should Be $expectedValues.OsLanguage
    }

    It 'Keyboard Layout is as expected' {
        $con.KeyboardLayout | Should Be $expectedValues.KeyboardLayout
    }
     
    $vols | ForEach-Object {
                It "Volume [$($_.DriveLetter)] file system type is as expected" {
                    $_.FileSystemType | Should Be $expectedValues.FileSystemType 
                }
            }
}

