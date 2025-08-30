Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Get-MonitorSerials {
    $monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi | ForEach-Object {
        $serial = ($_.SerialNumberID | ForEach-Object { [char]$_ }) -join ""
        $manufacturer = ($_.ManufacturerName | ForEach-Object { [char]$_ }) -join ""
        $product = ($_.UserFriendlyName | ForEach-Object { [char]$_ }) -join ""

        [PSCustomObject]@{
            Manufacturer = $manufacturer
            ProductName  = $product
            SerialNumber = $serial
        }
    }
    return $monitors
}

# Global variable to store monitor data
$global:MonitorData = @()

# Form
$form = New-Object Windows.Forms.Form
$form.Text = "Monitor Serial Tracker"
$form.Size = New-Object Drawing.Size(500,350)
$form.StartPosition = "CenterScreen"

# ListView
$list = New-Object Windows.Forms.ListView
$list.View = 'Details'
$list.FullRowSelect = $true
$list.Width = 460
$list.Height = 200
$list.Location = New-Object Drawing.Point(10,10)
$list.Columns.Add("Manufacturer",150)
$list.Columns.Add("Product",150)
$list.Columns.Add("Serial Number",150)

# Refresh Button
$refreshBtn = New-Object Windows.Forms.Button
$refreshBtn.Text = "Refresh"
$refreshBtn.Size = New-Object Drawing.Size(100,30)
$refreshBtn.Location = New-Object Drawing.Point(10,220)
$refreshBtn.Add_Click({
    $list.Items.Clear()
    $global:MonitorData = Get-MonitorSerials
    $global:MonitorData | ForEach-Object {
        $item = New-Object Windows.Forms.ListViewItem($_.Manufacturer)
        $item.SubItems.Add($_.ProductName)
        $item.SubItems.Add($_.SerialNumber)
        $list.Items.Add($item) | Out-Null
    }
    $timestampLabel.Text = "Last Refreshed: " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
})

# Export Button
$exportBtn = New-Object Windows.Forms.Button
$exportBtn.Text = "Export to CSV"
$exportBtn.Size = New-Object Drawing.Size(100,30)
$exportBtn.Location = New-Object Drawing.Point(120,220)
$exportBtn.Add_Click({
    if ($global:MonitorData.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("No data to export. Please refresh first.","Export Error","OK","Error")
        return
    }

    $saveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $saveFileDialog.Filter = "CSV files (*.csv)|*.csv"
    $saveFileDialog.Title = "Save Monitor Info"
    $saveFileDialog.FileName = "MonitorInfo.csv"
    
    if ($saveFileDialog.ShowDialog() -eq "OK") {
        $global:MonitorData | Export-Csv -Path $saveFileDialog.FileName -NoTypeInformation -Encoding UTF8
        [System.Windows.Forms.MessageBox]::Show("Data exported successfully.","Export Complete","OK","Information")
    }


})

# Timestamp Label
$timestampLabel = New-Object Windows.Forms.Label
$timestampLabel.Text = "Last Refreshed: Not yet"
$timestampLabel.AutoSize = $true
$timestampLabel.Location = New-Object Drawing.Point(10,260)


$form.Controls.Add($list)
$form.Controls.Add($refreshBtn)
$form.Controls.Add($timestampLabel)
$form.Controls.Add($exportBtn)

# Initial Load
$refreshBtn.PerformClick()

# Show form
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()
