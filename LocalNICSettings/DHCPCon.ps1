describe 'DHCP Configuration' {

$IPCONF = IPCONFIG /ALL
$IPAddIPv4 = $IPCONF | Select-String 'IPv4'
$DHCPServer = $IPCONF | Select-String 'DHCP Server'
$DHCPEnabled = $IPCONF | Select-String 'DHCP Enabled'
$MacAdd = $IPCONF | Select-String 'Physical Address'
$IPAutoConf = $IPCONF | Select-String 'Autoconfiguration Enabled'
$NICStatus = $IPCONF | Select-String 'Media State'
$Subnet = $IPCONF | Select-String 'Subnet'
$NBTCPIP = $IPCONF | Select-String "NetBIOS over Tcpip"

    Context 'Check IP Address' {

    It "IP Address is set correctly" {
          
        $IPAddIPv4 | Should -Be "    IPv4 Address. . . . . . . . . . . : 192.168.1.136(Preferred)"
          
    }
  }
}