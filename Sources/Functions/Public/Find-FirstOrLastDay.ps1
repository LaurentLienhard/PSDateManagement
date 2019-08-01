function Find-FirstOrLastDay {
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