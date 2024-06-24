$con = Get-Computerinfo
$hotFixes = $con.OsHotFixes | sort HotFixID

Describe 'hotFix' {

It 'Installed OS Hotfixes' {
$hotFixes[0] | Should -Be KB4497727
    }
}
