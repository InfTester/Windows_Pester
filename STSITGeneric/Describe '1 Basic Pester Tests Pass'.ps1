$con = Get-ComputerInfo
Describe '1 Basic Pester Tests Pass' {
    
    It "WindowsCurrentVersion: 6.3" {
          
        $con.WindowsCurrentVersion| Should Be '6.3'
          
    }
  
}