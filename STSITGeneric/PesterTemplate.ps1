#Pester Script Template

#Pester Variables 
#Variable 1 - Creates a variable that points to the SUT1-Tests Folder
$ScriptFolder =  "C:\Users\tonyl\OneDrive\Documents\Scripting\SUT1-Tests\"

#Variable 2 - Variable that pulls the Configuration.Json file data into memory for the SUT - The actual expected values
$SUT1Config = "$ScriptFolder\SUT1Config.Json"
$SUT1DesConf = Get-Content "$ScriptFolder\SUTActualConfig.Json" -Raw | ConvertFrom-Json

#Variable 3 -  A variable which pulls the SUT actual values which are to be tested into a JSON format. (SUTActualConfig.Json)
$SUT1Services = Get-service | Select-Object * | ConvertTo-Json | Out-File $ScriptFolder\SUTActualConfig.Json
#Variable 4 - A variable which converts the SUTs (SUTActualConfig.Json) configuration file, to a PSCustomObject.
$SUT1ServPSCustomObject = $SUT1Services | ConvertFrom-Json

#Testing the JSON File
$SUT1ServJSON = Get-Content "$ScriptFolder\SUTActualConfig.Json" -Raw | ConvertFrom-Json


describe 'powershell' { 
   context 'Windows features' {
		it 'installation of MicrosoftWindowsPowerShellV2' {
            $parameters = @{ 
                FeatureName = 'MicrosoftWindowsPowerShellV2'
                 }
            (Get-WindowsOptionalFeature -Online @parameters).State | should -Be Enabled
            }
                                  
        it 'installation of DHCP' {
            $parameters = @{
                FeatureName = 'SMB1Protocol-Server'
                     }
            (Get-WindowsOptionalFeature -Online @parameters).Installed | should -Be $Disabled
            }
            }
            }