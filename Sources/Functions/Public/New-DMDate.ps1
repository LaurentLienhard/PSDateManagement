function New-DMDate {
    [CmdletBinding(DefaultParameterSetName = "ByDay")]
    param (
        [Parameter(ParameterSetName = "ByDay")]
        [System.DateTime]$Date = (Get-Date),
        [Parameter(ParameterSetName = "ByInterval")]
        [System.DateTime]$StartDate,
        [Parameter(ParameterSetName = "ByInterval")]
        [System.DateTime]$EndDate
    )

    begin {
        $ScriptName = (Get-Variable -name MyInvocation -Scope 0 -ValueOnly).Mycommand
    }

    process {
        write-verbose "[$Scriptname] - BEGIN PROCESS"
        switch ($PSCmdlet.ParameterSetName) {
            "ByDay" {
                Write-Verbose "[$Scriptname] - $Date"
                $DateUse = [DATE]::new($date)
            }
            "ByInterval" {
                Write-Verbose "[$Scriptname] - Startdate : $($StartDate) and EndDate : $($EndDate)"
                $DateUse = [DATE]::New($StartDate, $EndDate)
            }
        }
    }

    end {
        return $DateUse
    }
}