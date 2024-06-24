Describe "Check Server Health" {
    Context "Disk Health" {
        it "Disk C has sufficient space" {
            (Get-DiskSpace -Disk "A").SpaceByPercentage | should BeGreaterThan '10'
        }
        it "Disk D has sufficient space" {
            (Get-DiskSpace -Disk "D").SpaceByPercentage | should BeGreaterThan '10'
        }
    }
    Context "Port Status" {
        foreach ($port in $required_ports) {
            it "$port is open" {
                Get-Port $port | should be "Open"
            }
        }
    }
}