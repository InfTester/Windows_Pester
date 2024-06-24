$net = Get-NetIPConfiguration
Describe 'networkIPAddress' {

It 'IP Address' {
$net.IPv4Address.IPAddress[0] | Should -Be 192.168.1.201
    }
}
