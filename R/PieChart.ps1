<#
.EXAMPLES
#    3D pie chart
Get-Process | 
    select -First 6 name, pm | 
    Out-PieChart -PieChartTitle "Top 6 Windows processes running" -DisplayToScreen -Pie3D

#    standard pie chart
Get-Process | 
     select -First 5 name, pm | 
     Out-PieChart -PieChartTitle "Top 5 Windows processes running" -DisplayToScreen
Display pie chart to screen
#use switch -DisplayToScreen

Get-Process | 
     select -First 5 name, pm | 
     Out-PieChart -PieChartTitle "Top 5 Windows processes running" -DisplayToScreen


     #Save pie chart
Get-Process | 
    select -First 5 name, pm | 
    Out-PieChart -PieChartTitle "Top 5 Windows processes running" -Pie3D -saveImage 'E:\OneDrive\Scripting\PesterScripts\Win_Process.png'


#>

Function Out-PieChart {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [psobject] $inputObject,
        [Parameter()]
        [string] $PieChartTitle,
        [Parameter()]
        [int] $ChartWidth = 800,
        [Parameter()]
        [int] $ChartHeight = 400,
        [Parameter()]
        [string[]] $NameProperty,
        [Parameter()]
        [string] $ValueProperty,
        [Parameter()]
        [switch] $Pie3D,
        [Parameter()]
        [switch] $DisplayToScreen,
        [Parameter()]
        [string] $saveImage
    )
    begin {
        Add-Type -AssemblyName System.Windows.Forms.DataVisualization
        # Frame
        $Chart = [System.Windows.Forms.DataVisualization.Charting.Chart]@{
            Width       = $ChartWidth
            Height      = $ChartHeight
            BackColor   = 'White'
            BorderColor = 'Black'
        }
        # Body
        $null = $Chart.Titles.Add($PieChartTitle)
        $Chart.Titles[0].Font = "segoeuilight,20pt"
        $Chart.Titles[0].Alignment = "TopCenter"
        # Create Chart Area
        $ChartArea = [System.Windows.Forms.DataVisualization.Charting.ChartArea]::new()
        $ChartArea.Area3DStyle.Enable3D = $Pie3D.ToBool()
        $ChartArea.Area3DStyle.Inclination = 50
        $Chart.ChartAreas.Add($ChartArea)
        # Define Chart Area
        $null = $Chart.Series.Add("Data")
        $Chart.Series["Data"].ChartType = [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]::Pie
        # Chart style
        $Chart.Series["Data"]["PieLabelStyle"] = "Outside"
        $Chart.Series["Data"]["PieLineColor"] = "Black"
        $Chart.Series["Data"]["PieDrawingStyle"] = "Concave"
        $chart.Series["Data"].IsValueShownAsLabel = $true
        $chart.series["Data"].Label = "#PERCENT\n#VALX"
        # Set ArrayList
        $XColumn = [System.Collections.ArrayList]::new()
        $yColumn = [System.Collections.ArrayList]::new()
    }
    process {
        if (-not $valueProperty) {
            $numericProperties = foreach ($property in $inputObject.PSObject.Properties) {
                if ([Double]::TryParse($property.Value, [Ref]$null)) {
                    $property.Name
                }
            }
            if (@($numericProperties).Count -eq 1) {
                $valueProperty = $numericProperties
            }
            else {
                throw 'Unable to automatically determine properties to graph'
            }
        }
        if (-not $LabelProperty) {
            if ($inputObject.PSObject.Properties.Count -eq 2) {
                $LabelProperty = $inputObject.Properties.Name -ne $valueProperty
            }
            elseif ($inputObject.PSObject.Properties.Item('Name')) {
                $LabelProperty = 'Name'
            }
            else {
                throw 'Cannot convert Data'
            }
        }
        # Bind chart columns
        $null = $yColumn.Add($InputObject.$valueProperty)
        $null = $xColumn.Add($inputObject.$LabelProperty)
    }
    end {
        # Add data to chart
        $Chart.Series["Data"].Points.DataBindXY($xColumn, $yColumn)
        # Save file
        if ($psboundparameters.ContainsKey('saveImage')) {
            try{
                if (Test-Path (Split-Path $saveImage -Parent)) {
                    $SaveImage = $pscmdlet.GetUnresolvedProviderPathFromPSPath($saveImage)
                    $Chart.SaveImage($saveImage, "png")
                } else {
                    throw 'Invalid path, the parent directory must exist'
                }
            } catch {
                throw
            }
        }
        # Display Chart to screen
        if ($DisplayToScreen.ToBool()) {
            $Form = [Windows.Forms.Form]@{
                Width           = 800
                Height          = 450
                AutoSize        = $true
                FormBorderStyle = "FixedDialog"
                MaximizeBox     = $false
                MinimizeBox     = $false
                KeyPreview      = $true
            }
            $Form.controls.add($Chart)
            $Chart.Anchor = 'Bottom, Right, Top, Left'
            $Form.Add_KeyDown({
                if ($_.KeyCode -eq "Escape") { $Form.Close() }
            })
            $Form.Add_Shown( {$Form.Activate()})
            $Form.ShowDialog() | Out-Null
        }
    }
}

#CSS codes
$header = @"
<style>
    h1 {

        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;

    }
    
    h2 {

        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;

    }
      
   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }
  
    #CreationDate {

        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;

    }

    .StopStatus {

        color: #ff0000;
    }
  
    .RunningStatus {

        color: #008000;
    }


</style>
"@
