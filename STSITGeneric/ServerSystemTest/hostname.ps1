Describe 'Host Configuration' {
 Context 'Check that the hostname of the SUT is correct' {
      it 'The hostname should have the value of DESKTOP-0NI678D' {
      $env:COMPUTERNAME | Should -be 'DESKTOP-0NI678D'
        }
    }
}
