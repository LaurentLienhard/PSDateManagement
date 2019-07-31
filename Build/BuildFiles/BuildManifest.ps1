$ErrorActionPreference = "Stop";

Write-Verbose "[BUILDMANIFEST TASK][BEGIN]"
Write-Verbose "[BUILDMANIFEST TASK] Adding functions to export..."
$FunctionsToExport = ($settings.PublicFunctions).basename

New-ModuleManifest -Path $settings.ModulePsd1 -Author $settings.Author -CompanyName $settings.CompanyName -RootModule ("./" + $settings.ProjectName + ".psm1") -Description "Test Module" -Copyright "My"

if ($settings.FunctionsToExport -ne $null) {
    Update-ModuleManifest -Path $settings.ModulePsd1 -FunctionsToExport $settings.FunctionsToExport
}
Write-Verbose "[BUILDMANIFEST TASK][END]"
