describe 'Operating System' {
    context 'Service Availability' {
        it 'Eventlog is running' {
            $svc = Get-Service -Name Eventlog
            $svc.Status | Should -Be running
        }
    }
}