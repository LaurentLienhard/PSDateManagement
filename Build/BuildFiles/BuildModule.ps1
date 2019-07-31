$ErrorActionPreference = "Stop";

Write-Verbose "[BUILDMODULE TASK][BEGIN]"
Write-Verbose "[BUILDMODULE TASK] Creating output path for $($settings.ProjectName)"
New-Item -Path $settings.BuildOutputDir  -ItemType Directory -Force | Out-Null

Write-Verbose "[BUILDMODULE TASK] Loading all sources files"

$MainPSM1Contents = @()
$MainPSM1Contents += $settings.Enums
$MainPSM1Contents += $settings.Classes
$MainPSM1Contents += $settings.PrivateFunctions
$MainPSM1Contents += $settings.PublicFunctions

Write-Verbose "[BUILDMODULE TASK] building main psm1"
$Date = Get-Date
"#Generated at $($Date) by $($settings.author)" | Out-File -FilePath $settings.ModulePsm1 -Encoding utf8 -Append
Foreach ($file in $MainPSM1Contents) {
    Get-Content $File.FullName | Out-File -FilePath $settings.ModulePsm1 -Encoding utf8 -Append
}

if (Test-Path -Path "$$RessourcesFodler") {
    Write-Verbose "[BUILDMODULE TASK] Add ressources to Module "
    $RessourcesList = Get-ChildItem -Path $settings.RessourcesFodler

    foreach ($ressources in $RessourcesList) {
        $RessourcesPath = $RessourcesFodler + $ressources.Name
        $DestinationPath = $settings.ModuleOutDir + "\Ressources\" + $ressources.Name
        Copy-Item -Path $RessourcesPath -Destination $DestinationPath -Force -Recurse -Confirm:$false
    }
    Write-Verbose "[BUILDMODULE TASK] All ressources add to Module "
}
Write-Verbose "[BUILDMODULE TASK][END]"