param(
    $Services = @(
        'DHCP', 'DNSCache','Eventlog', 'PlugPlay', 'RpcSs', 'lanmanserver',
        'LmHosts', 'Lanmanworkstation', 'MpsSvc', 'WinRM', 'w32tm'
    )
)

describe 'Operating System' {
    context 'Service Availability' {
        $Services | ForEach-Object {
            it "[$_] should be running" {
                (Get-Service $_).Status | Should -Be "Running, Stopped, Stopped, Stopped, Running, Stopped, Running, Running, Running, Stopped" }
                  }
}