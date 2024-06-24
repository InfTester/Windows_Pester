 
describe 'Adobe Photoshop' {

	$status = ('C:\Users\tonl\Desktop\Adobe Photoshop.Ink').Status

	it 'should be installed' {
	    $Status | should Be $installed

	}
}
