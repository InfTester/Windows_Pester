function Set-File {
param(
[string]$FilePath
)
$fileContents = Get-Content -Path $FilePath -Raw
$replacement = $fileContents -replace 'foo','bar'
Set-Content -Path $FilePath -Value $replacement -NoNewLine
}