<#
	.NOTES
=========================================================================
		Created on: 10/05/2021
		Created by: Tony Law
		Filename:   DNS_Server_Specific_Tests.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute the system integration level (SIT) tests for a Windows DNS Server. 
		Note the following:
        	This script should be run with json files containing the expected values for specific servers - see the $jsonPath and $expectedValues variables.
        	The file paths should be changed where necessary.
#>

$jsonPath = 'C:\Users\Administrator\Documents\DNS_ServerRole_i-0cbb6eab1d8025286.json'
$expectedValues = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).ConfigItems

$DNS = Get-WindowsFeature -Name DNS
$DNSTools = Get-WindowsFeature -Name RSAT-DNS-Server
$DNSForwarder = Get-DnsServerForwarder
$DNSServer = Get-DnsServer
$DnsSOARec = Get-DnsServerResourceRecord -ZoneName $expectedValues.DNS.PrimaryZone | Where-Object {$_.RecordType -eq 'SOA'}
$ZoneFile = 'C:\Users\Administrator\Documents\Zones.txt'
$ZoneAttrs = Get-DnsServerZone | Where-Object {$_.Zonename -eq $expectedValues.DNS.PrimaryZone} 
$Date = (Get-Date).AddDays(-1)

Describe 'DNS Role Specific SIT Tests' {

       	Context 'Check DNS is Installed' {
                It  "DNS is Installed" {
        	    $DNS.Installed | Should Be $True
            	    }

    		It  "RSAT Server Tools are Installed" {
        	    $DNSTools.Installed | Should Be $True
            	    }
        }

	Context 'Check DNS Service is Running' {
		It 'DNS Service should be running' {
		   (Get-Service DNS).status | Should Be 'Running'
		   }

		It 'DNS Cache Service should be running' {
		   (Get-Service Dnscache).status | Should Be 'Running'
		   }
        }

        Context 'Primary Zone Tests' {
		Get-DnsServerZone | Out-File $ZoneFile
		It "Primary Zones should be as expected" {
            	    $ZoneFile | Should Contain $expectedValues.DNS.PrimaryZone
            	    }
       	}	

        Context 'Check Attributes of Primary Zone' {	
  	        It  "Zone Type is Primary" {
        	    $ZoneAttrs.ZoneType | Should Be 'Primary'
            	    }
   
                It  "Zone Type is Integrated with AD" {
                    $ZoneAttrs.IsDsIntegrated | Should Be $True
            	    }
    
 		It  "Zone is not a Reverse Lookup Zone" {
                    $ZoneAttrs.IsReverseLookupZone | Should Be $False
            	    }
        }

        Context 'Check Forwarder Attributes' { 
                It  "Forwarder IPAddress is as expected" {
                    $DNSForwarder.IPAddress | Should Be $expectedValues.Forwarder.IPAddress
            	    }

                It  "Forwarder UseRootHint is as expected" {
                    $DNSForwarder.UseRootHint | Should Be $expectedValues.Forwarder.UseRootHint
            	    }

                It  "Forwarder Timeout is as expected" {
                    $DNSForwarder.TimeOut | Should Be $expectedValues.Forwarder.TimeOut
            	    }

                It  "Forwarder EnableReOrdering is as expected" {
                    $DNSForwarder.EnableReordering | Should Be $expectedValues.Forwarder.EnableReordering
            	    }
        }

	 Context 'Check Advanced Settings ' { 
                It  "RoundRobin is as expected" {
                    $DnsServer.ServerSetting.RoundRobin | Should Be $expectedValues.Advanced.RoundRobin
            	    }

                It  "BindSecondaries is as expected" {
                    $DnsServer.ServerSetting.BindSecondaries | Should Be $expectedValues.Advanced.BindSecondaries
            	    }
        }

        Context 'Check for Eventlog Errors ' {
                 It 'There should be no DNS errors within the past 24 hours' {
		    $ErrorVar = Get-EventLog -EntryType Error -Source '*DNS*' -LogName Application -After $Date
		    $ErrorVar | Should BeNullOrEmpty
		    }
        }

        Context 'Zone Aging tests ' {
		
		 $DNSServer.ServerZoneAging | ForEach-Object {

                 if ( $_.Zonename -eq $expectedValues.DNS.PrimaryZone) {

                     It 'Aging Enabled flag should be as expected' {
                         $_.AgingEnabled | Should be $expectedValues.Aging.AgingEnabled
                         }

                     It 'Refresh Interval should be as expected' {
                         $_.RefreshInterval | Should be $expectedValues.Aging.RefreshInterval
                         }

                     It 'No Refresh Interval should be as expected' {
                         $_.NoRefreshInterval | Should be $expectedValues.Aging.NoRefreshInterval
                         }
            	     }   
                 }
        }

        Context 'Check SOA Record Arributes ' {
                It  "SOA Primary Server is as expected" {
                    $DnsSOARec.RecordData.PrimaryServer | Should Be $expectedValues.SOA.PrimaryServer
            	    }

                It  "SOA Responsible Person is as expected" {
                    $DnsSOARec.RecordData.ResponsiblePerson | Should Be $expectedValues.SOA.ResponsiblePerson
            	    }

                It  "SOA Refresh Interval is as expected" {
                    $DnsSOARec.RecordData.RefreshInterval | Should Be $expectedValues.SOA.RefreshInterval
            	    }

                It  "SOA ReTry Delay setting is as expected" {
                    $DnsSOARec.RecordData.RetryDelay | Should Be $expectedValues.SOA.RetryDelay
            	    }

                It  "SOA Expire Limit is as expected" {
                    $DnsSOARec.RecordData.ExpireLimit | Should Be $expectedValues.SOA.ExpireLimit
            	    }

                It  "SOA Minimum Time To Live is as expected" {
                    $DnsSOARec.RecordData.MinimumTimeToLive | Should Be $expectedValues.SOA.MinTimeToLive
            	    }
        }
}