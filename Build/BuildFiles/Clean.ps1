$ErrorActionPreference = "Stop";

Write-Verbose "[CLEAN TASK][BEGIN]"
Write-Verbose "[CLEAN TASK] test if output build directory already exist..."
if (Test-Path -Path $settings.OutputDir) {
    Write-Verbose "[CLEAN TASK] Pre-build module find => Suppress"
    Remove-Item -Path $settings.OutputDir -force -recurse -confirm:$false
} else {
    Write-Verbose "[CLEAN TASK] Nothing to do..."
}
Write-Verbose "[CLEAN TASK][END]"