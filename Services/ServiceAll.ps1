Import-Module -Name poshspec -Verbose:$false -ErrorAction Stop

describe 'Operating System' {
    context 'Availability' {
        service DHCP status { should -Be running }
        service DNSCache status { should -Be running }
        service Eventlog status { should -Be running }
        service PlugPlay status { should -Be running }
        service RpcSs status { should -Be running }
        service lanmanserver status { should -Be running }
        service LmHosts status { should -Be running }
        service Lanmanworkstation status { should -Be running }
        service MpsSvc status { should -Be running }
        service WinRM status { should -Be running }
    }
}
