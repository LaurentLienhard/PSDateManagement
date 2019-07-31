# BuildModuleDemo

For all my tasks I use a lot of variable.

Before I used my `Init` task to do it. Today I use a `Build.Settings.ps1` that contains all my variable.

I call this file everytime I need it in my different files

# > Branch PSAKE_CUTFILES_DEPENDENCIES

After cutting these tasks into different files, I realized that all these tasks required additional modules.

At the beginning I installed these modules by hand but after a while I thought there must be a way to automate that too.

After observing several repository on github, I found the PSDepend module which allows to automatically install the necessary dependencies

Finally automatically ;-) after defining a list in a file I named `requirements.psd1`.

```¨Powershell
@{
    PSDependOptions  = @{
        Target     = 'CurrentUser'
        Parameters = @{
            Force = $True
        }
    }


    Pester           = @{
        Version    = 'latest'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
    psake            = 'latest'
    PSScriptAnalyzer = 'latest'
    PSDeploy         = 'Latest'
}
```

To find me more easily I put this file in a folder `Dependencies`

For the configuration of this dependency file, I'll let you see on the github of [PSDepend](https://github.com/RamblingCookieMonster/PSDepend/)

After that I make a little piece of code to run PSDepend

```Powershell
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
```

But the next question was: Where am I going to put this piece of code?

I found 2 solutions :
1. Use my Init.ps1 script but I left them very early and he no longer serves me
2. Make a script (build.ps1) that I could call to launch my PSake tasks. In this file I can run, before calles my task, the PSDepend's script

I chose the second. So, for that, I put a `Build.ps1` file at the root of my module

I took the opportunity to do some cleaning and consolidate all my build files in the Build folder

Call build.ps1 => Invoke-Psake => It find the task in `Module.Build.ps1` => It run the script associate to the task

this time, to run a task I use the following command :
```Powershell
 .\Build.ps1 -Tasks (clean) [-verbose]
```