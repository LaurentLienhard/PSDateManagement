function New-DMDate {
    <#
    .SYNOPSIS
        Create new date object
    .DESCRIPTION
        Create a DATE object from the current date of the day or by giving a date range.
        Methods can be applied on this object to perform treatments such as:
            * Calculation of the number of working days between 2 dates
            * Calculation of the number of days between 2 dates
    .PARAMETER Date
        The date that will be used to instantiate the DATE object
    .PARAMETER StartDate
        The start date of the interval to instantiate the DATE object
    .PARAMETER EndDate
        The end date of the interval to instantiate the DATE object
    .EXAMPLE
        PS > New-DMDate
        FirstDay            LastDay             aDate
        --------            -------             -----
        01/01/0001 00:00:00 01/01/0001 00:00:00 31/07/2019 15:13:22

        This example returns a DATE object based on today's date
    .EXAMPLE
        PS > New-DMDate -Date ((get-date).AddDays(-6))
        FirstDay            LastDay             aDate
        --------            -------             -----
        01/01/0001 00:00:00 01/01/0001 00:00:00 25/07/2019 15:15:12

        This example returns a DATE object based on today's date minus 6 days
    .EXAMPLE
        PS > New-DMDate -StartDate ((get-date).AddDays(-6)) -EndDate ((get-date))
        FirstDay            LastDay             aDate
        --------            -------             -----
        25/07/2019 15:16:43 31/07/2019 15:16:43 25/07/2019 15:16:43

        This example returns a DATE object taking StartDate as the first day and EndDate as the last day.
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
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