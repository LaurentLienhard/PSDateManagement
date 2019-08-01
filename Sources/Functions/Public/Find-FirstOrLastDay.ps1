function Find-FirstOrLastDay {
    <#
    .SYNOPSIS
        Find first or last day in a period
    .DESCRIPTION
        Find first ou last day (Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday) in a specific period
    .PARAMETER Date
        The date corresponding to the search period
    .PARAMETER Day
        The day sought among those of the week (Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday)
    .PARAMETER Which
        What day is searched (first or last)
    .EXAMPLE
        PS > $period = New-DMDate
        PS > $period.SetFirstDayAndLastDay()
        PS > Write-Output (Find-FirstOrLastDay -Date $period -Day Monday -Which First)

        lundi 5 août 2019 00:00:00

        find the first Monday of the period from the first day of the current month to the last day of the current month
    .EXAMPLE
        PS > $period = New-DMDate -Date ((get-date).AddMonths(-1))
        PS > $period.SetFirstDayAndLastDay()
        PS > Find-FirstOrLastDay -Date $period -Day Friday -Which Last

        vendredi 26 juillet 2019 23:59:59

        Find the last Friday of the previous month
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    [CmdletBinding()]
    param (
        [DATE]$Date,
        [ValidateSet("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")]
        [System.DayOfWeek]$Day,
        [ValidateSet("First", "Last")]
        [System.String]$Which
    )

    begin {
        $ScriptName = (Get-Variable -name MyInvocation -Scope 0 -ValueOnly).Mycommand
    }

    process {
        write-verbose "[$Scriptname] - BEGIN PROCESS"
        $result = $Date.FindFirstOrLastDay($Day, $Which)
    }
    end {
        return $result
    }
}