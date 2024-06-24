describe 'powershell' { 
   context 'Windows features' {
		it 'installation of DNS' {
            $parameters = @{
                Name = 'DNS'
                     }
            (Get-WindowsOptionalFeature @parameters).Installed | should be $false
            }
                                  
        it 'installation of DHCP' {
            $parameters = @{
                ComputerName = 'hostname'
                Name = 'DHCP'
                     }
            (Get-WindowsOptionalFeature @parameters).Installed | should be $false
            }
    }
}