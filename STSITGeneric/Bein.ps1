Describe 'Simple test' { 
   Context 'Simple test' {
        It 'Simple test' {

'green' | Should -BeIn @('red', 'yellow', 'green')
}
}
}