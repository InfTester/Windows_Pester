function Get-SystemInfo
{
    <#
        .SYNOPSIS
        Generates a summary of local or remote computer system configuration

        .DESCRIPTION
        This function generates a summary of a local or remote computer system configuration by querying CIM classes, including:

        Hardware model
        Processor (Model, Frequency, number of physical/logical cores)
        Operating system version
        Uptime
        Network interfaces and IP addresses
        Logical disks (drive letter, file system type, name, remaining and total capacity)
        Memory installed (free / total amount)
        Pagefile configuration
        Powershell version installed

        .NOTES   
        Name       : Get-SystemInfo
        Author     : Thomas Novak
        Version    : 1.1
        DateCreated: 2019-09-06

        .PARAMETER ComputerName
        The computer hostname to query for information

        .EXAMPLE
        Get-SystemInfo

        Description:
        Will query localhost for system information

        .EXAMPLE
        Get-SystemInfo -ComputerName server01,server02

        Description:
        Will query remote computers server01 and server02 for system information

        .EXAMPLE
        'server01','server02' | Get-SystemInfo

        Description:
        Will query remote computers server01 and server02 for system information
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('gsi')]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Provide the target hostname")]
        [Alias('Hostname', 'cn')]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )
	
    process
    {
        foreach ($Computer in $ComputerName)
        {
            try 
            {
                $session = New-CimSession -ComputerName $Computer
                $System = Get-CimInstance -Class Win32_ComputerSystem -CimSession $session
                $OS = Get-CimInstance -Class Win32_OperatingSystem -CimSession $session
                $Processor = Get-CimInstance -Class Win32_Processor -CimSession $session
                $Network = Get-CimInstance -Class Win32_NetworkAdapterConfiguration -CimSession $session
                $Network2 = Get-CimInstance -Class Win32_NetworkAdapter -CimSession $session
                $Disk = Get-CimInstance -Class Win32_LogicalDisk -CimSession $session
                $Pagefile = Get-CimInstance -Class Win32_PageFileSetting -CimSession $session
                Remove-CimSession -CimSession $session -ErrorAction SilentlyContinue
            }
            catch 
            {
                $sysinfo = [ordered]@{
                    Hostname       = $Computer
                    Model          = $null
                    Uptime         = $null
                    Processor      = $null
                    OS             = $null
                    IPAddress      = $null
                    LogicalDisks   = $null
                    Memory         = $null
                    PageFile       = $null
                    PSVersion      = $null
                }
                $obj = New-Object PSObject -Property $sysinfo
                return $obj	
            }
			
            $Uptime = New-TimeSpan $OS.LastBootUpTime $OS.LocalDateTime -ErrorAction SilentlyContinue
            $sysinfo = [ordered]@{
                Hostname       = $System.Name
                Model          = $System.Model
                Uptime         = "{0} days {1} hours (Last Boot: {2})" -f $Uptime.Days, $Uptime.Hours, $OS.LastBootUpTime
                Processor      = ($Processor | % {"{0} ({1} Core(s), {2} Logical Processor(s))" -f $_.Name, $_.NumberOfCores, $_.NumberOfLogicalProcessors} | Out-String).Trim()
                OS             = "{0} ({1})" -f $OS.Caption, $OS.OSArchitecture
                IPAddress      = ($Network | ? IPEnabled -eq $true | % { "{0} - {1}" -f ($Network2 | ? DeviceID -eq $_.Index).NetConnectionID, (($_.IPAddress) -join ", ") } | Out-String).trim()
                LogicalDisks   = ($Disk | ? { $_.DriveType -eq 3 -and $_.Size -notlike $null } | % { "[{0}] {1}\ ({2}) = {3:N2} / {4:N2} GB ({5:N1}% Free)" -f $_.FileSystem, $_.DeviceID, $_.VolumeName, ($_.FreeSpace / 1GB), ($_.Size / 1GB), (($_.FreeSpace / $_.Size) * 100) } | Out-String).Trim()
                Memory         = "{0:N2} / {1:N2} GB ({2:N1}% Free)" -f ($OS.FreePhysicalMemory / 1MB), ($OS.TotalVisibleMemorySize / 1MB), (($OS.FreePhysicalMemory / $OS.TotalVisibleMemorySize) * 100)
                PageFile       = if ($Pagefile) { "{0} - {1:N2} GB / {2:N2} GB (Initial/Maximum)" -f $Pagefile.Name, ($Pagefile.InitialSize / 1KB), ($Pagefile.MaximumSize / 1KB) } else { "Pagefile not set" };
                PSVersion      = Invoke-Command -ComputerName $Computer -ScriptBlock { "{0}.{1}" -f $PSVersionTable.PSVersion.Major, $PSVersionTable.PSVersion.Minor }
            }
            $obj = New-Object PSObject -Property $sysinfo
            Write-Output $obj
        }
    }
}