$assoc = New-Object PSObject -Property @{
    Id = 42
    Name = "Slim Shady"
    Owner = "Eminem"
}

Write-host ($assoc.Id.ToString() + "  -  "  + $assoc.Name + "  -  " + $assoc.Owner)