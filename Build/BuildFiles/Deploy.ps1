param(
    [System.String]$DeployType
)
$ErrorActionPreference = "Stop"

#Example : invoke-psake -buildFile .\Module.Build.ps1 -taskList Deploy -Verbose -parameters @{'DeployType' = 'DEV'}
Write-Verbose "[DEPLOY TASK][BEGIN]"
Write-Verbose "[DEPLOY TASK] in $($DeployType) environement"
if ($null -eq $DeployType) {
    $DeployType = "DEV"
}
$PSDeployParam = @{
    Path    = ".\Module.PSDeploy.ps1"
    Tags    = $DeployType
    Force   = $true
    Verbose = $true
}

Invoke-PSDeploy @PSDeployParam
Write-Verbose "[DEPLOY TASK][END]"