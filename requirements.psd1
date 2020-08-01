@{
    PSDependOptions  = @{
        Target = './Dependencies'
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