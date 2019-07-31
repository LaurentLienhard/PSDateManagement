[cmdletbinding(DefaultParameterSetName = 'Task')]
param(
    [parameter(ParameterSetName = 'task', position = 0)]
    [System.String[]]$Tasks = 'Default',
    [parameter(ParameterSetName = 'task')]
    [System.String]$DeployType = 'DEV',
    [parameter(ParameterSetName = 'Help')]
    [switch]$Help
)

Clear-Host

if (-not (Get-Module -Name PSDepend -ListAvailable)) {
    Write-Verbose "[BUILD] Install module dependecies"
    Get-PackageProvider -Name Nuget -ForceBootstrap | Out-Null
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-module -Name PSDepend -Repository PSGallery -Scope CurrentUser
    Import-Module -Name PSDepend -Verbose:$false
    Invoke-PSDepend -Path './Dependencies/requirements.psd1' -Install -Import -Force -WarningAction SilentlyContinue
    Write-Verbose "[BUILD] Install module dependecies done"
} else {
    Write-Verbose "[BUILD] Dependencies allready installed"
}

Write-Verbose "[BUILD] Execute psake task"
$psakefile = './Build/Module.Build.ps1'
if ($PSCmdlet.ParameterSetName -eq 'Help') {
    Get-PSakeScriptTasks -buildFile $psakeFile |
    Format-Table -Property Name, Description, Alias, DependsOn
} else {
    $PSakeParams = @{
        BuildFile = $psakefile
        nologo    = $true
    }
    if ($PSBoundParameters['verbose']) {
        $PSakeParams.add('verbose', $verbose)
    }
    if ($Tasks -eq "Deploy") {
        Invoke-psake @PSakeParams -taskList Deploy -parameters @{'DeployType' = $DeployType }
        exit ( [int]( -not $psake.build_success ) )
    } else {
        Invoke-psake @PSakeParams -taskList $Tasks
        exit ( [int]( -not $psake.build_success ) )
    }

}

#invoke-psake -buildFile .\Build\Module.Build.ps1 -taskList Deploy -Verbose -parameters @{'DeployType' = 'PROD' }

<# $PSakeParams = @{
    BuildFile = $psakefile
    nologo    = $true
}
if ($PSBoundParameters['verbose']) {
    $PSakeParams.add('verbose', $verbose)
}
Invoke-psake @PSakeParams -taskList $Tasks
exit ( [int]( -not $psake.build_success ) ) #>