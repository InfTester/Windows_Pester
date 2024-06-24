describe 'Logical Disks' {
$session = New-CimSession
                $System = Get-CimInstance -Class Win32_ComputerSystem -CimSession $session
                $OS = Get-CimInstance -Class Win32_OperatingSystem -CimSession $session
                $Processor = Get-CimInstance -Class Win32_Processor -CimSession $session
                $Network = Get-CimInstance -Class Win32_NetworkAdapterConfiguration -CimSession $session
                $Network2 = Get-CimInstance -Class Win32_NetworkAdapter -CimSession $session
                $Disk = Get-CimInstance -Class Win32_LogicalDisk -CimSession $session
                $Pagefile = Get-CimInstance -Class Win32_PageFileSetting -CimSession $session

#    $vols = Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' -and -not [string]::IsNullOrEmpty($_.DriveLetter)}

    context 'OS Drive Configuration' {
  #      $vols | ForEach-Object {
        it "The C drive [$($_.DriveLetter)] is a Local Fixed Disk " {
  
              $disk.Description | Should be 'Local Fixed Disk'
}

        it "The OS is the [$($_.DriveLetter)] DRIVE" {

              $disk.DeviceID | Should be 'c:'
}
        it "The [$($_.DriveLetter)] Filesystem type is NTFS" {

              $disk.FileSystem | Should be 'NTFS'
}
 
 #StatusInfo                   : 
it "StatusInfo is " {
  
              $disk.StatusInfo | Should be $null }

#Caption                      : C:
it "Caption is " {
  
              $disk.Caption | Should be 'C:' }

#Description                  : Local Fixed Disk
it "Description is " {
  
              $disk.Description | Should be 'Local Fixed Disk' }

#InstallDate                  : 
it "InstallDate is " {
  
              $disk.InstallDate | Should be $null }

#Name                         : C:
it "Name is " {
  
              $disk.Name | Should be 'C:' }

#ConfigManagerErrorCode       : 
it "ConfigManagerErrorCode is " {
  
              $disk.ConfigManagerErrorCode | Should be $null }

#ConfigManagerUserConfig      : 
it "ConfigManagerUserConfig is " {
  
              $disk.ConfigManagerUserConfig | Should be $null }

#CreationClassName            : Win32_LogicalDisk
it "CreationClassName is " {
  
              $disk.CreationClassName | Should be 'Win32_LogicalDisk' }

#ErrorCleared                 : 
it "ErrorCleared " {
  
              $disk.ErrorCleared | Should be $null }

#ErrorDescription             : 
it "ErrorDescription is null" {
  
              $disk.ErrorDescription | Should be $null }

#LastErrorCode                : 
it "LastErrorCode " {
  
              $disk.LastErrorCode | Should be $null }

#PNPDeviceID                  : 
it "PNPDeviceID is null" {
  
              $disk.PNPDeviceID | Should be $null }

#PowerManagementCapabilities  : 
it "PowerManagementCapabilities is null " {
  
              $disk.PowerManagementCapabilities | Should be $null }

#PowerManagementSupported     : 
it "The C drive Status is null " {
  
              $disk.PowerManagementSupported | Should be $null }

#SystemCreationClassName      : Win32_ComputerSystem
it "SystemCreationClassName is Win32_ComputerSystem" {
  
              $disk.SystemCreationClassName | Should be 'Win32_ComputerSystem' }

#SystemName                   : DESKTOP-HHC2S8D
it "SystemName is " {
  
              $disk.SystemName  | Should be 'DESKTOP-HHC2S8D' }

#Access                       : 0
it "Access is " {
  
              $disk.Access | Should be '0' }

#BlockSize                    : 
it "BlockSize is " {
  
              $disk.BlockSize | Should be $null }

#ErrorMethodology             : 
it "ErrorMethodology is null " {
  
              $disk.ErrorMethodology | Should be $null }

#NumberOfBlocks               : 
it "NumberOfBlocks is " {
  
              $disk.NumberOfBlocks | Should be $null }

#Purpose                      : 
it "Purpose is null " {
  
              $disk.Purpose | Should be $null }

#FreeSpace                    : 52099436544
it "FreeSpace is greater than 42099436544 " {
  
              $disk.FreeSpace | Should begreaterthan '42099436544' }
              
#Size                         : 126852526080
it "Size is 126852526080" {
  
              $disk.Size | Should belike 126852526080 }

#Compressed                   : False
it "Compressed is False" {
  
              $disk.Compressed | Should be False }

#DriveType                    : 3
it "DriveType is 3" {
  
              $disk.DriveType | Should be '3' }

#FileSystem                   : NTFS
it "FileSystem is NTFS" {
  
              $disk.FileSystem | Should be 'NTFS' }

#MaximumComponentLength       : 255
it "MaximumComponentLength is 255 " {
  
              $disk.MaximumComponentLength | Should be '255' }
#MediaType                    : 12
it "MediaType is 12" {
  
              $disk.MediaType | Should be '12' }
#ProviderName                 : 
it "ProviderName is null " {
  
              $disk.ProviderName | Should be $null }

#QuotasDisabled               : True
it "QuotasDisabled is True" {
  
              $disk.QuotasDisabled | Should be 'True' }

#QuotasIncomplete             : False
it "QuotasIncomplete is False" {
  
              $disk.QuotasIncomplete | Should be 'False' }

#QuotasRebuilding             : False
it "QuotasRebuilding is False " {
  
              $disk.QuotasRebuilding | Should be 'False' }

#SupportsDiskQuotas           : True
it "SupportsDiskQuotas is True " {
  
              $disk.SupportsDiskQuotas | Should be 'True' }

#SupportsFileBasedCompression : True
it "SupportsFileBasedCompression is True" {
  
              $disk.SupportsFileBasedCompression | Should be 'True'}

#VolumeDirty                  : False
it "VolumeDirty is False" {
  
              $disk.VolumeDirty | Should be 'False' }

#VolumeName                   : Windows
it "VolumeName is Windows" {
  
              $disk.VolumeName | Should be 'Windows' }

#VolumeSerialNumber           : 402111CA
it "VolumeSerialNumber" {
  
              $disk.VolumeSerialNumber | Should be '402111CA' }

#PSComputerName               : 
it "PSComputerName  " {
  
              $disk.PSComputerName | Should be $null }

#CimClass                     : root/cimv2:Win32_LogicalDisk
it "CimClass" {
  
              $disk.CimClass | Should be 'root/cimv2:Win32_LogicalDisk' }

#CimInstanceProperties        : {Caption, Description, InstallDate, Name...}
<#it "CimInstanceProperties is " {
  
              $disk.CimInstanceProperties | Should be 'Caption = "C:"' } #>

#CimSystemProperties          : Microsoft.Management.Infrastructure.CimSystemProperties
it "CimSystemProperties " {
  
              $disk.CimSystemProperties | Should be 'Microsoft.Management.Infrastructure.CimSystemProperties' }

}
}
