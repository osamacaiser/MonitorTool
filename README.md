# Monitor Info Tools (PowerShell)

This repository contains two PowerShell scripts that retrieve and display information about connected monitors using Windows Management Instrumentation (WMI).

## Scripts

### 1. Get-MonitorInfo.ps1

A command-line script that queries monitor details from the root\wmi namespace using the WmiMonitorID class.

#### Functionality:

Retrieves monitor information via WMI.

Extracts and cleans string data for:

 - Manufacturer
 - Model (UserFriendlyName)
 - Serial Number
 - Outputs results as a PSCustomObject.

#### Example Usage:

```
 .\Get-MonitorInfo.ps1
 ```

#### Example Output:
```
Manufacturer Model         SerialNumber
------------ -----         ------------
DELL        U2415          ABC123XYZ
HP          E243           9LM87654
```
### 2. test_gui_02.ps1

A Windows Forms GUI application that provides a simple interface to view monitor details.

#### Functionality:

Uses the same WmiMonitorID class to retrieve:
- Manufacturer
- Product Name (UserFriendlyName)
- Serial Number
- Displays results in a Windows Forms ListView.
- Includes a button to refresh monitor data dynamically.

#### Features:

- GUI with a resizable form.
- Table view with columns for Manufacturer, Product Name, and Serial Number.
- Supports multiple monitors.

#### Example Usage:

.\test_gui_02.ps1


#### Screenshot (conceptual):

```
+-------------------------------------------------------+
|  Monitor Serial Tracker                               |
+-------------------------------------------------------+
| Manufacturer | Product Name     | Serial Number       |
|--------------|------------------|---------------------|
| DELL         | U2415            | ABC123XYZ           |
| HP           | E243             | 9LM87654            |
+-------------------------------------------------------+
```

Requirements

Windows PowerShell 5.1 or PowerShell 7+

Windows OS with WMI support (root\wmi namespace must be accessible)

Notes

Get-MonitorInfo.ps1 is lightweight and suited for quick scripting or automation.

test_gui_02.ps1 is more user-friendly, designed for IT technicians to view monitor info visually.