#A desktop Ping test, quiet is used so no info is displayed on screen.
# Count 1 runs the test once
Test-Connection -ComputerName DESKTOP-HHC2S8D -Quiet -Count 1

# The followng test is a negative test as above, used when the server is offline.
-not (Test-Connection -ComputerName DESKTOP-HHC2S8D -Quiet -Count 1)

