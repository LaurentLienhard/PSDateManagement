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