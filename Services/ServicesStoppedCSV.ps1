get-service | 
where-Object Status -eq 'stopped' |
select-object Name |
export-csv .\Stopped-services.csv -Force