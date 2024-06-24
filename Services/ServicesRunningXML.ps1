get-service | 
where-Object Status -eq 'running' |
select-object Name |
export-csv .\running-services.csv -Force