Class Date {
    [Datetime]$FirstDay
    [Datetime]$LastDay
    [Datetime]$aDate
    hidden [System.Int32]$NumberOfDays
    hidden [System.Int32]$WorkingDays

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
            $this.FirstDay = $StartDate
            $this.LastDay = $EndDate
            $This.aDate = $StartDate
        }
    }

    [Void] SetFirstDayAndLastDay () {
        $this.FirstDay = Get-Date $this.aDate -day 1 -hour 0 -minute 0 -second 0
        $this.LastDay = (($this.FirstDay).AddMonths(1).AddSeconds( - 1))
    }

    [System.Int32] NumberDayBetweenFirstDayAndLastDay () {
        $this.NumberOfDays = ([datetime]$this.LastDay - [datetime]$this.FirstDay).Days
        return $this.NumberOfDays
    }

    [System.Int32] NumberOFWorkingDays () {
        $we = [System.DayOfWeek]::Saturday, [System.DayOfWeek]::Sunday
        $this.WorkingDays = 0
        $now = $this.FirstDay

        while ($Now -le $this.LastDay) {
            if ($now.DayOfWeek -notin $we) {
                $this.WorkingDays++
            }
            $now = $now.AddDays(1)
        }
        Return $this.WorkingDays
    }
}