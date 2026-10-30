# MonitorTool

A lightweight PowerShell utility for retrieving monitor information, including manufacturer, model, and serial number, from connected displays on Windows systems.

This project is designed as a practical utility for hardware inventory, support workflows, and quick troubleshooting. It includes both a command-line script and a Windows Forms GUI for viewing monitor metadata.

## Why this project exists

When supporting workstations or auditing hardware, it is often useful to quickly identify a monitor and its serial number without manually inspecting the device. MonitorTool provides a simple way to query that information directly from Windows WMI.

## Features

- Query connected monitors using WMI (`root\wmi` / `WmiMonitorID`)
- Retrieve and clean:
  - Manufacturer
  - Model / user-friendly name
  - Serial number
- Output as PowerShell objects for scripting and automation
- GUI version for a more visual, user-friendly experience
- Works on Windows systems with WMI enabled

## Repository contents

- `Get-MonitorInfo.ps1` – command-line script for retrieving monitor details
- `test_gui_02.ps1` – Windows Forms GUI for viewing monitor details
- `screenshots/` – interface screenshots and examples
- `README.md` – project documentation

## Requirements

- Windows 10 / Windows 11
- PowerShell 5.1 or PowerShell 7+
- WMI support enabled on the system

## Quick start

### Command-line version

Run the script from PowerShell:

```powershell
.\Get-MonitorInfo.ps1
```

Example output:

```powershell
Manufacturer Model        SerialNumber
------------ -----        ------------
DELL         U2415        ABC123XYZ
HP           E243         9LM87654
```

### GUI version

Run the GUI script:

```powershell
.\test_gui_02.ps1
```

This opens a simple Windows Forms window that lists each connected monitor and its basic details.

## How it works

The scripts query the `WmiMonitorID` WMI class in the `root\wmi` namespace, which exposes monitor metadata including manufacturer, model, and serial number identifiers. The scripts then convert the raw byte arrays into readable strings and format them for output.

## Example output

```powershell
@{
  Manufacturer = 'DELL'
  Model        = 'U2415'
  SerialNumber = 'ABC123XYZ'
}
```

## Screenshot

![MonitorTool GUI](./screenshots/gui_001.png)

## Current status

This project is a small but useful personal utility focused on a single problem: identifying monitor hardware details quickly and reliably on Windows systems.

## Future improvements

Potential enhancements for a more polished portfolio version include:

- CSV/JSON export support
- Better parameter validation and error handling
- Remote machine monitoring support
- PowerShell module packaging
- Automated tests and CI checks
- Improved GUI polish and filtering

## Notes

This project is intentionally focused and easy to run, making it a good example of a practical Windows automation utility built with PowerShell.

