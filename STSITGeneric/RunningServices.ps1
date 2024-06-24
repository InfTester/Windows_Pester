describe 'powershell' { 
   context 'Windows features' {
		it 'installation of DNS' {
            $parameters = @{
                                Name = 'TFTP'
                     }
            (Get-WindowsOptionalFeature $parameters).Disabled | should be $false
            }
                                  
            }
            }