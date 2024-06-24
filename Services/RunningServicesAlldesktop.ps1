$DTStoppedServices = @('AJRouter')


describe 'Operating System Services - ' {
    context 'Service Availability Running Services' {
        $DTStoppedServices | ForEach-Object {
            it "$_.Status should be running" {
                Get-Service $_.Status | Should -Be running
            }ipconfig | Select-String 'gateway'