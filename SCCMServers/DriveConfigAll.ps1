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
}
}