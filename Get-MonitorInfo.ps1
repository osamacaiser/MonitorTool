# Get monitor info using WMI (root\wmi\WmiMonitorID)
$monitors = Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorID

foreach ($monitor in $monitors) {
    $manufacturer = ($monitor.ManufacturerName | ForEach-Object { [char]$_ }) -join '' -replace '\0',''
    $model        = ($monitor.UserFriendlyName | ForEach-Object { [char]$_ }) -join '' -replace '\0',''
    $serial       = ($monitor.SerialNumberID   | ForEach-Object { [char]$_ }) -join '' -replace '\0',''
    
    [PSCustomObject]@{
        Manufacturer = $manufacturer
        Model        = $model
        SerialNumber = $serial
    }
}
