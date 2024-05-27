<#
	.NOTES
=========================================================================
		Created on: 23/04/2021
		Created by: Tony Law
		Filename:   CA_Client_Tests.Tests.ps1
=========================================================================
	.DESCRIPTION
		This script uses Pester to execute the tests for a Windows Certification Authority Client to validate that the clients have the expected
		certificates.
		Note the following:
        	This script should be run with json files containing the expected values for specific server - see the $jsonPath and $Values variables.
		This script should also be run alongside the CAServer_SIT.Tests.ps1 script, which validates that the CA server is working as expected.
		The certificate thumbprint should be changed depending on the certificate/certificates being tested.
        	The file paths should be changed where necessary.
#>

$jsonPath = 'C:\WkDir\CA_Client_Tests_i-095b091394c77b3c4.json'
$Values = (Get-Content -Path $jsonPath -Raw | ConvertFrom-Json).Certificate

Describe 'CA client tests' {
	It 'The Root CA should be in the Trusted Root Certification Authorities list' {
		$RootCA = Get-ChildItem  -Path Cert:\LocalMachine\Root | Where-Object {$_.Subject -match "tviaas-CA1-CA"}
		$RootCA | Should Not BeNullOrEmpty
	}

	It 'Certificate deployed by GPO should be listed in the certificate store' {
		$cert = Get-ChildItem -Path Cert:LocalMachine\MY | Where-Object {$_.Thumbprint -Match "6FC0F47603AC09297186F063B6194A094130726C"}
		$cert | Should Not BeNullOrEmpty
	}

	It 'Certificate deployed by GPO should have the expected subject' {
		$subject = (Get-ChildItem -Path Cert:LocalMachine\MY | Where-Object {$_.Thumbprint -Match "6FC0F47603AC09297186F063B6194A094130726C"}).Subject
		$subject | Should Be $Values.Subject
	}

	It 'Certificate deployed by GPO should have the expected issuer' {
		$issuer = (Get-ChildItem -Path Cert:LocalMachine\MY | Where-Object {$_.Thumbprint -Match "6FC0F47603AC09297186F063B6194A094130726C"}).Issuer
		$issuer | Should Be $Values.Issuer
	}

	It 'Certificate deployed by GPO should have the expected expiry date' {
		$expiry = (Get-ChildItem -Path Cert:LocalMachine\MY | Where-Object {$_.Thumbprint -Match "6FC0F47603AC09297186F063B6194A094130726C"}).NotAfter
		$expiry | Should Be $Values.Expiry
	}

	It 'Certificate deployed by GPO should have the expected issue date' {
		$issuedate = (Get-ChildItem -Path Cert:LocalMachine\MY | Where-Object {$_.Thumbprint -Match "6FC0F47603AC09297186F063B6194A094130726C"}).NotBefore
		$issuedate | Should Be $Values.IssueDate
	}

    It 'There should be no certificates due to expire within 14 days' {
        $certs = Get-ChildItem -Path cert:\* -Recurse -ExpiringInDays 14
        $certs | Should BeNullOrEmpty
    }
}