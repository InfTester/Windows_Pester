describe 'powershell' { 
   context 'Windows features' {
		it 'installation of DNS' {
            $parameters = @{

              Name = 'DNS'
                     }
            (Get-WindowsOptionalFeature -Online @parameters).Installed | should be $false
            }
                                  
        it 'installation of DHCP' {
            $parameters = @{
                Name = 'DHCP'
                     }
            (Get-WindowsOptionalFeature @parameters).Installed | should be $false
            }
            }
            }