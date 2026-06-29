$ErrorActionPreference = "Stop"
Write-Host "Finding MSI..."
$msi = gci -recurse -filter '*.msi' $env:CI_PROJECT_DIR/data/windows/ | select -expand FullName
Write-Host "Found MSI at $msi, uninstalling..."
$p = Start-Process -FilePath "msiexec.exe" -ArgumentList "/qn /x $msi" -Passthru -Wait -NoNewWindow
$p.WaitForExit()
if ($p.ExitCode -ne 0) {
    throw "msiexec was not successful. Received exit code $($p.ExitCode)"
}
if (Test-Path C:\cinc-project\cinc-auditor) {
    throw "MSI was uninstalled however C:\cinc-project\cinc-auditor still exists"
} else {
	Write-Host "MSI Uninstalled successfully!"
}
