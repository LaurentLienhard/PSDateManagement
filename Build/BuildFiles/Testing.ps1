$ErrorActionPreference = "Stop";

Write-Verbose "[TESTING TASK][BEGIN]"
Import-Module Pester -MinimumVersion 4.8.1
$params = @{
    Script       = $settings.UnitTestPath
    OutputFile   = $settings.ResultUnitTestFile
    OutputFormat = 'NUnitXml'
    PassThru     = $true
    Show         = 'Failed', 'Fails', 'Summary'
}

$results = Invoke-Pester @params
if ($results.FailedCount -gt 0) {
    Write-Error -Message "Failed [$($results.FailedCount)] Pester tests."
}
Write-Verbose "[TESTING TASK][END]"