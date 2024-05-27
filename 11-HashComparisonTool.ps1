<#
	.NOTES
=========================================================================
		Created on: 06/07/2021
		Created by: Tony Law
		Filename:  11-HashComparisonTool.ps1
=========================================================================
	.DESCRIPTION
		This script is used to validate file hashes. Simply add the filename and path to line 13 variable entry and the expected hash on line 15.
        Change the algorithm to the expected algorithm on line 16 and run the script. If the value is correct, 'matches' 
#>

#Modify here
$fileName =  "D:\ForUpload\11-OutputToCSV.ps1" #Enter the file path and name that you want to check
$originalHash = "56B68BDDD02C899AC216720F2D09ABC5E90B0268F608913BD1A06DFA21ADC8C0" #Enter the original file hash provided by the downloade provider
$algorithm = "SHA256" #SHA1, SHA256, SHA384, SHA512, MD5

#This is where the magic happens
$fileHash = Get-FileHash -Algorithm $algorithm $fileName | ForEach { $_.Hash} |  Out-String
$filehash = $fileHash.Trim()
If ($fileHash -eq $originalHash) {
    Write-Host "File = " $fileName
    Write-Host "Algorithm = " + $algorithm
    Write-Host "Original hash = " $originalHash
    Write-Host "Current hash = " $fileHash
    Write-Host "The 'Hash' matches the expected value as is correct. This file is safe to use"
}
else {
    Write-Host "File = " $fileName
    Write-Host "Algorithm = " $algorithm
    Write-Host "Original hash = " $originalHash
    Write-Host "Current hash = " $fileHash
    Write-Host "The 'Hash' is not as expected, and doesn't match the expected value. DO NOT use this file"
}