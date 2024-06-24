describe 'IIS' { 
   context 'Windows features' {
		it 'installs the Web-Server Windows feature' {
            $parameters = @{
                Name = 'Web-Server'
            }
            (Get-WindowsOptionalFeature @parameters).Installed | should be $False
        }
    }
}

