 
<#
	.NOTES
=========================================================================
		Created on: 16/06/2021
		Created by: Tony Law
		Filename:   RSOP_GPO_Properties_Tests.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute system integration level (SIT) tests which check the details of the Group Policy Objects resident on a local Server. 
		Note the following:
        	This script should be run with json files containing the expected values for specific servers - see the $jsonPath and $expectedValues variables.
        	The file paths should be changed where necessary.
#>

 $DateTime = Get-Date
 Get-GPResultantSetOfPolicy -ReportType Xml -Path C:\Users\Administrator\Documents\RSOPResultsFile.xml 
                                                                                               
 [xml]$RSOPResults = Get-Content -Path C:\Users\Administrator\Documents\RSOPResultsFile.xml 

 $jsonPath = 'C:\Users\Administrator\Documents\RSOP-GPO-Properties-i-095b091394c77b3c4.json'
 $expectedValues = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).ConfigItems

Write-Host "This test script was executed on the following date and time: $DateTime on the following server $env:COMPUTERNAME"

Describe 'GPO RSOP Script' {
 
        Context 'GPO Local Group Policy tests ' {

                     It 'Name of GPO should be "Local Group Policy"' {
                         $RSOPResults.Rsop.ComputerResults.GPO.name[0] | Should Be $expectedValues.GPOLocal.Name 
                         }
        
                     It 'Versiondirectory of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Versiondirectory[0] | Should be $expectedValues.GPOLocal.Versiondirectory
                         }

                     It 'VersionSysVol of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Versionsysvol[0] | Should be $expectedValues.GPOLocal.Versionsysvol
                         }

                     It 'Enabled Status of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Enabled[0] | Should be $expectedValues.GPOLocal.Enabled
                         }

                     It 'IsValid Status of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.IsValid[0] | Should be $expectedValues.GPOLocal.IsValid
                         }

                     It 'FilterAllowed Status of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.FilterAllowed[0] | Should be $expectedValues.GPOLocal.FilterAllowed
                         }

                     It 'AccessDenied Status of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.AccessDenied[0] | Should be $expectedValues.GPOLocal.AccessDenied
                         }

                     It 'SOMPath value of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.SOMPath[0] | Should be $expectedValues.GPOLocal.SOMPath
                         }

                     It 'SOMOrder value of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.SOMOrder[0] | Should be $expectedValues.GPOLocal.SOMOrder
                         }

                     It 'AppliedOrder value of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.AppliedOrder[0] | Should be $expectedValues.GPOLocal.AppliedOrder
                         }

                     It 'LinkOrder value of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.LinkOrder[0] | Should be $expectedValues.GPOLocal.LinkOrder
                         }

                     It 'Link Enabled value of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.Enabled[0] | Should be $expectedValues.GPOLocal.LinkEnabled
                         }

                     It 'No Override status of GPO Local Group Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.Nooverride[0] | Should be $expectedValues.GPOLocal.NoOverride
                         }
                }  
                                      
        Context 'GPO Default Domain Policy tests ' {

                     It 'Name of GPO should be "Default Domain Policy"' {
                         $RSOPResults.Rsop.ComputerResults.GPO.name[1] | Should Be $expectedValues.GPODefault.Name 
                         }
        
                     It 'Versiondirectory of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Versiondirectory[1] | Should be $expectedValues.GPODefault.Versiondirectory
                         }

                     It 'VersionSysVol of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Versionsysvol[1] | Should be $expectedValues.GPODefault.Versionsysvol
                         }

                     It 'Enabled Status of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Enabled[1] | Should be $expectedValues.GPODefault.Enabled
                         }

                     It 'IsValid Status of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.IsValid[1] | Should be $expectedValues.GPODefault.IsValid
                         }

                     It 'FilterAllowed Status of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.FilterAllowed[1] | Should be $expectedValues.GPODefault.FilterAllowed
                         }

                     It 'AccessDenied Status of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.AccessDenied[1] | Should be $expectedValues.GPODefault.AccessDenied
                         }

                     It 'SOMPath value of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.SOMPath[1] | Should be $expectedValues.GPODefault.SOMPath
                         }

                     It 'SOMOrder value of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.SOMOrder[1] | Should be $expectedValues.GPODefault.SOMOrder
                         }

                     It 'AppliedOrder value of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.AppliedOrder[1] | Should be $expectedValues.GPODefault.AppliedOrder
                         }

                     It 'LinkOrder value of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.LinkOrder[1] | Should be $expectedValues.GPODefault.LinkOrder
                         }

                     It 'Link Enabled value of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.Enabled[1] | Should be $expectedValues.GPODefault.LinkEnabled
                         }

                     It 'No Override status of GPO Default Domain Policy should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.Nooverride[1] | Should be $expectedValues.GPODefault.NoOverride
                         }
                }

        Context 'GPO WSUS GPO 2 tests ' {
            	        
                     It 'Name of GPO should be "WSUS GPO 2"' {
                         $RSOPResults.Rsop.ComputerResults.GPO.name[2] | Should Be  $expectedValues.GPOWSUS.Name  
                         }
        
                     It 'Versiondirectory of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Versiondirectory[2] | Should be $expectedValues.GPOWSUS.Versiondirectory
                         }

                     It 'VersionSysVol of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Versionsysvol[2] | Should be $expectedValues.GPOWSUS.VersionSysVol
                         }

                     It 'Enabled Status of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Enabled[2] | Should be $expectedValues.GPOWSUS.Enabled 
                         }

                     It 'IsValid Status of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.IsValid[2] | Should be $expectedValues.GPOWSUS.IsValid
                         }

                     It 'FilterAllowed Status of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.FilterAllowed[2] | Should be $expectedValues.GPOWSUS.FilterAllowed
                         }

                     It 'AccessDenied Status of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.AccessDenied[2] | Should be $expectedValues.GPOWSUS.AccessDenied
                         }

                     It 'SOMPath value of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.SOMPath[2] | Should be $expectedValues.GPOWSUS.SOMPath
                         }

                     It 'SOMOrder value of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.SOMOrder[2] | Should be $expectedValues.GPOWSUS.SOMOrder
                         }

                     It 'AppliedOrder value of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.AppliedOrder[2] | Should be $expectedValues.GPOWSUS.AppliedOrder
                         }

                     It 'LinkOrder value of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.LinkOrder[2] | Should be $expectedValues.GPOWSUS.LinkOrder
                         }

                     It 'Link Enabled value of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.Enabled[2] | Should be $expectedValues.GPOWSUS.LinkEnabled
                         }

                     It 'No Override status of GPO WSUS GPO 2 should be as expected' {
                         $RSOPResults.Rsop.ComputerResults.GPO.Link.Nooverride[2] | Should be $expectedValues.GPOWSUS.NoOverride
                         }

                }
}