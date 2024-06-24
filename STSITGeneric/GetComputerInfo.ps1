<#PS C:\WINDOWS\system32> help Get-ComputerInfo

NAME
    Get-ComputerInfo
    
SYNOPSIS
    Gets a consolidated object of system and operating system properties.
    
    
SYNTAX
    Get-ComputerInfo [[-Property] <System.String[]>] [<CommonParameters>]
    
    
DESCRIPTION
    The `Get-ComputerInfo` cmdlet gets a consolidated object of system and operating system properties. 
    This cmdlet was introduced in Windows PowerShell 5.1.
    

RELATED LINKS
    Online Version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-compute
    rinfo?view=powershell-5.1&WT.mc_id=ps-gethelp

REMARKS
    To see the examples, type: "get-help Get-ComputerInfo -examples".
    For more information, type: "get-help Get-ComputerInfo -detailed".
    For technical information, type: "get-help Get-ComputerInfo -full".
    For online help, type: "get-help Get-ComputerInfo -online"
    #>

    #Use the Property Parameter

<#    PS C:\WINDOWS\system32> Get-ComputerInfo -Property *Memory*


CsTotalPhysicalMemory      : 17107689472
CsPhyicallyInstalledMemory : 16777216
OsTotalVisibleMemorySize   : 16706728
OsFreePhysicalMemory       : 10191860
OsTotalVirtualMemorySize   : 35581096
OsFreeVirtualMemory        : 21938744
OsInUseVirtualMemory       : 13642352
OsMaxProcessMemorySize     : 137438953344
#>