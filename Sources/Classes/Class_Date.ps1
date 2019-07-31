Class Date {
    [Datetime]$FirstDayOFMonth
    [Datetime]$LastDayOfMonth
    [Datetime]$aDate
    [System.Int32]$NumberOfDays

    Date() {
        $this.aDate = Get-Date
    }

    Date([Datetime]$Date) {
        $this.aDate = $Date
    }

    Date([Datetime]$StartDate, [Datetime]$EndDate) {
        if ($EndDate -lt $StartDate) {
            Write-Error -Message "EndDate ($($EndDate)) should be greater than StartSate ($($StartDate))"
        } else {
            $this.FirstDayOFMonth = $StartDate
            $this.LastDayOfMonth = $EndDate
            $This.aDate = $StartDate
        }
    }

    [Void] SetFirstDateAndLastDateOfMonth () {
        $this.FirstDayOFMonth = Get-Date $this.aDate -day 1 -hour 0 -minute 0 -second 0
        $this.LastDayOfMonth = (($this.FirstDayOFMonth).AddMonths(1).AddSeconds( - 1))
    }

    [System.Int32] NumberDayBetweenStartDateAndEndDate () {
        $this.NumberOfDays = ([datetime]$this.LastDayOfMonth - [datetime]$this.FirstDayOFMonth).Days
        return $this.NumberOfDays
    }
}