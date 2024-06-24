$domain = [Environment]::UserDomainName

    Describe 'Host Configuration' {
 Context 'Check that the Domain configuration of the SUT' {
      it 'The Domain Name should have the value of DESKTOP-0NI678D' {
      $domain | Should -Be 'DESKTOP-0NI678D'
        }
    }
}