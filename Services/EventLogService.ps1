<#

VERSION CONTROL
 Script Reference Number:
 Script Version: 0.1
 Script Creator: TonyL
 Creation Date: 01.12.2020
 Tested with Powershell Version: 5.1.14393.3866 
 Tested with Pester Version: 5.0.4
 Tested on Server Version: Microsoft Windows Server 2019 Datacenter
 Tested on Desktop Version: N/A
 IDE Used: PowerShell ISE
 
 This Pester Test will uses the open standard Common Information Model CIM to look up expected values and then compare against the actual value
 If the value is not as expected, then the test will Fail and will report in the Shell a failed test with applicable data, why the test failed.
 If the value returned is as expected, the test will show as Passed. No further data will be supplied.
 The format of the output will be as the following example
 Tests completed in 1.59s 
 Tests Passed: 5, Failed: 0, Skipped: 0 NotRun: 0
 For these test to run successfully the $session variable and the appropriate CIM variable need to be executed within the script. 
    i.e.
    $System = Get-CimInstance -Class Win32_ComputerSystem -CimSession $session
    $session = New-CimSession
 To execute these tests either use an IDE and load the .ps1 script, or use the following example syntax at the command line 
 PS C:\Windows\system32\>Invoke-Pester -Path 'C:\Users\tonyl\Documents\PSscripts\BIOSConfigAllCIM.ps1.
 IF IN DOUBT - DO NOT RUN OR ATTEMPT TO MODIFY THIS SCRIPT  
#>

#System Under Test (SUT) 


#Set CimSession Variables.
$session = New-CimSession
$System = Get-CimInstance -Class Win32_ComputerSystem -CimSession $session


<#
$System = Get-CimInstance -Class Win32_ComputerSystem -CimSession $session
$system | Select *
$OS = Get-CimInstance -Class Win32_OperatingSystem -CimSession $session
$Processor = Get-CimInstance -Class Win32_Processor -CimSession $session
$Network = Get-CimInstance -Class Win32_NetworkAdapterConfiguration -CimSession $session
$Network2 = Get-CimInstance -Class Win32_NetworkAdapter -CimSession $session
$Pagefile = Get-CimInstance -Class Win32_PageFileSetting -CimSession $session
$bios = Get-CimInstance -Class Win32_BIOS -CimSession $session
#>


$Con=Get-Service -Name EventLog

Describe "INFRASTRUCTURE SYSTEM INTEGRATION TEST" {
It 'Name                : EventLog'  { $con.Name           | Should -Be  EventLog } 

It 'RequiredServices    : {}'  { $con.RequiredServices     | Should -Be  $null } 

It 'CanPauseAndContinue : False'  { $con.CanPauseAndContinue  | Should -Be  False } 
    It 'CanPauseAndContinue : False'  { $con.CanPauseAndContinue  | Should -Not -Be True } 

It 'CanShutdown         : True'  { $con.CanShutdown          | Should -Be  True } 
It 'CanShutdown         : True'  { $con.CanShutdown          | Should -Not -Be False } 

It 'CanStop             : True'  { $con.CanStop              | Should -Be  True }
It 'CanStop             : True'  { $con.CanStop              | Should -Not -Be False }

It 'DisplayName         : Windows Event Log'  { $con.DisplayName          | Should -Be  'Windows Event Log' } 

It 'DependentServices   : {Wecsvc, AppVClient, netprofm, NlaSvc}'  { $con.DependentServices[0].Name    | Should -Be  'Wecsvc' } 
It 'DependentServices   : {Wecsvc, AppVClient, netprofm, NlaSvc}'  { $con.DependentServices[1].Name    | Should -Be  'NcdAutoSetup' }
It 'DependentServices   : {Wecsvc, AppVClient, netprofm, NlaSvc}'  { $con.DependentServices[2].Name    | Should -Be  'AppVClient' }
It 'DependentServices   : {Wecsvc, AppVClient, netprofm, NlaSvc}'  { $con.DependentServices[3].Name    | Should -Be  'netprofm' }
It 'DependentServices   : {Wecsvc, AppVClient, netprofm, NlaSvc}'  { $con.DependentServices[4].Name    | Should -Be  'NlaSvc' }

It 'MachineName         : .'  { $con.MachineName          | Should -Be  '.' } 

It 'ServiceName         : EventLog'  { $con.ServiceName          | Should -Be  EventLog } 

It 'ServicesDependedOn  : {}'  { $con.ServicesDependedOn   | Should -Be $null } 

It 'ServiceHandle       : '  { $con.ServiceHandle        | Should -Be SafeServiceHandle } 

It 'Status              : Running'  { $con.Status               | Should -Be  Running } 
It 'Status              : Running'  { $con.Status               | Should -Not -Be  Stopped } 

It 'ServiceType         : Win32ShareProcess'  { $con.ServiceType         | Should -Be "Win32OwnProcess, Win32ShareProcess" } 

It 'StartType           : Automatic'  { $con.StartType         | Should -Be  Automatic } 
It 'StartType           : Manual'  { $con.StartType            | Should -Not -Be  Manual } 
It 'StartType           : Manual'  { $con.StartType            | Should -Not -Be  Disabled } 

It 'Site                : '  { $con.Site                 | Should -Be $null  } 

It 'Container           : '  { $con.Container            | Should -Be $null  } 
}