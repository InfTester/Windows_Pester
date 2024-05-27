<#
	.NOTES
=========================================================================
		Created on: 20/05/2021
		Created by: Tony Law
		Filename:   DHCP_Server_Specific_Tests.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute the system integration level (SIT) tests for a Windows DHCP Server. 
		Note the following:
        	This script should be run with json files containing the expected values for specific servers - see the $jsonPath and $expectedValues variables.
        	The file paths should be changed where necessary.
#>

$jsonPath = "C:\Users\Administrator\Documents\DHCP_ServerRole_i-04b398edb874c067b.json"
$expectedValues = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).ConfigItems

$DHCP = Get-WindowsFeature -Name DHCP
$DHCPTools = Get-WindowsFeature -Name RSAT-DHCP
$DHCPScope = Get-DhcpServerv4Scope
$DHCPSS = Get-DhcpServerSetting 
$DHCPAudit = Get-DhcpServerAuditLog
$DHCPDNS = Get-DhcpServerv4DnsSetting
$DHCPFail = Get-DhcpServerv4Failover
$DHCPBind = Get-DhcpServerv4Binding
$DHCPCred = Get-DhcpServerDnsCredential
$DHCPPol = Get-DhcpServerv4Policy
$DHCPFilt = Get-DhcpServerv4FilterList
$Date = (Get-Date).AddDays(-1)

Describe 'DHCP Role Specific SIT Tests' {

       	Context 'Check DHCP is Installed' {
                It  "DHCP is Installed" {
                    $DHCP.Installed | Should Be $True
                    }

                It  "Display name is DHCP Server" {
                    $DHCP.DisplayName | Should Be 'DHCP Server'
                    }

                It  "RSAT Server Tools are Installed" {
                    $DHCPTools.Installed | Should Be $True
               	    }

                It  "Display name of RSAT Server Tools " {
                    $DHCPTools.DisplayName | Should Be 'DHCP Server Tools'
                    }
        }

        Context 'Check DHCP-Server Service is Running' {
                It  'DHCP-ServerService should be running' {
                    (Get-Service DHCPServer).status | Should Be 'Running'
                    }
        }

        Context 'Check DHCP Scope Attributes' { 
                It  "Scope Id is as expected" {
                    $DHCPScope.ScopeId | Should Be $expectedValues.Scope.Id
                    }

                It  "Scope Name is as expected" {
                    $DHCPScope.Name | Should Be $expectedValues.Scope.Name
            	    }

                It  "Subnet Mask is as expected" {
                    $DHCPScope.SubnetMask.IPAddressToString | Should Be $expectedValues.Scope.Subnet
            	    }

                It  "Start Range is as expected" {
                    $DHCPScope.StartRange | Should Be $expectedValues.Scope.StartRange
                    }

                It  "End Range is as expected" {
                    $DHCPScope.EndRange | Should Be $expectedValues.Scope.EndRange
                    }

                It  "Lease Duration is as expected" {
                    $DHCPScope.LeaseDuration | Should Be $expectedValues.Scope.LeaseDuration
                    }

                It  "Scope State is as expected" {
                    $DHCPScope.State | Should Be $expectedValues.Scope.State
                    }
        }
		
        Context 'Check DHCP Server Settings' { 
                It  "Server is joined to Domain" {
                    $DHCPSS.IsDomainJoined | Should Be $expectedValues.Settings.DomJoined
                    }

                It  "Server is Authorised" {
                    $DHCPSS.IsAuthorized | Should Be $expectedValues.Settings.Authorised
                    }

                It  "Dynanic Bootp flag is as expected" {
                    $DHCPSS.DynamicBootp | Should Be $expectedValues.Settings.Bootp
                    }

                It  "Conflict Detection Attempts is as expected" {
                    $DHCPSS.ConflictDetectionAttempts | Should Be $expectedValues.Settings.ConflDetect
                    }
        }
	
        Context 'Check for Eventlog Errors ' {
                It 'There should be no DHCP errors within the past 24 hours' {
                    $ErrorVar = Get-EventLog -EntryType Error -Source '*DHCP*' -LogName Application -After $Date
                    $ErrorVar | Should BeNullOrEmpty
                    }
        }

        Context 'Check Audit Logging ' {
                It  "Audit Logging is enabled" {
                    $DHCPAudit.Enable | Should Be $expectedValues.Audit.Logging
                    }

                It  "Audit File Path is as expected" {
                    $DHCPAudit.Path | Should Be $expectedValues.Audit.Path
                    }
        }

        Context 'Check DHCP DNS Settings ' {
                It  "Dynamic Updates setting is as expected" {
                    $DHCPDNS.DynamicUpdates | Should Be $expectedValues.DNS.Updates
                    }

                It  "Delete DNS Records on Lease Expiry setting is as expected" {
                    $DHCPDNS.DeleteDnsRROnLeaseExpiry | Should Be $expectedValues.DNS.LeaseExpiry
                    }

                It  "Name Protection setting is as expected" {
                    $DHCPDNS.NameProtection | Should Be $expectedValues.DNS.NameProtection
                    }
        }

        Context 'Check Failover Settings ' {
                It  "Failover setting is as expected" {
                    $DHCPFail | Should BeNullorEmpty
                    }
        }

        Context 'Check Server Bindings ' {
                It  "Server Binding setting is as expected" {
                    $DHCPBind | Should BeNullorEmpty
                    }
        }

        Context 'Check Server Credentials  ' {
                It  "Server Credential setting UserName is as expected" {
                    $DHCPCred.UserName | Should BeNullorEmpty
                    }

                It  "Server Credential setting Domain Name is as expected" {
                    $DHCPCred.DomainName | Should BeNullorEmpty
                    }
        }

        Context 'Check Policy settings  ' {
                It  "Server Policy setting is as expected" {
                    $DHCPPol | Should BeNullorEmpty
                    }
        }

        Context 'Check Filter settings ' {
                It  "DHCP Filter Allowed List is set up as expected" {
                    $DHCPFilt.Allow | Should Be $True
                    }
		
                It  "DHCP Filter Deny List is set up as expected" {
                    $DHCPFilt.Deny | Should Be $False
                    }
        }
}