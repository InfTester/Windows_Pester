$UpperBoundPacketSize = 4096
do {
    Write-Output "Testing packet size $UpperBoundPacketSize"
    $PingOut = ping $IpToPing -n 1 -l $UpperBoundPacketSize -f
    $UpperBoundPacketSize -= 1
} while ($PingOut[2] -like "*fragmented*")
 
$UpperBoundPacketSize += 1
$Mtu = $UpperBoundPacketSize + 28
 
New-Object -TypeName PSObject -Property @{
    MTU = $MTU
}