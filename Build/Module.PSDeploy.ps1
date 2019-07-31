. ..\Build.Settings.ps1


$source = ""
$LocalPowershellModule = ""
$LocalCoreModule = ""

$source = $script:settings.BuildOutputDir
$LocalPowershellModule = [environment]::getfolderpath("mydocuments") + '\WindowsPowerShell\Modules\' + $script:settings.ProjectName
$LocalCoreModule = [environment]::getfolderpath("mydocuments") + '\PowerShell\Modules\' + $script:settings.ProjectName

Deploy Dev {

    By FileSystem {

        FromSource $source
        To $LocalPowershellModule
        Tagged Dev
        WithOptions @{
            Mirror = $true
        }
    }

    By FileSystem {

        FromSource $source
        To $LocalCoreModule
        Tagged Dev
        WithOptions @{
            Mirror = $true
        }
    }

}