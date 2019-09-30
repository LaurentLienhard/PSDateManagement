Class Date {
    [Datetime]$FirstDay
    [Datetime]$LastDay
    [Datetime]$aDate
    hidden [System.Int32]$NumberOfDays
    hidden [System.Int32]$WorkingDays
    hidden [System.DateTime]$FirstOrLastDay

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

    [datetime] FindFirstOrLastDay ([System.DayOfWeek]$Day, [System.String]$which) {
        switch ($which) {
            "First" {
                $This.FirstOrLastDay = $this.FirstDay
                while ($This.FirstOrLastDay.DayOfWeek -ne $Day) {
                    $This.FirstOrLastDay = $This.FirstOrLastDay.AddDays(1)
                }
            }
            "Last" {
                $This.FirstOrLastDay = $this.LastDay
                while ($This.FirstOrLastDay.DayOfWeek -ne $Day) {
                    $This.FirstOrLastDay = $This.FirstOrLastDay.AddDays(-1)
                }
            }
            Default {
                $This.FirstOrLastDay = $this.FirstDay
                while ($This.FirstOrLastDay.DayOfWeek -ne $Day) {
                    $This.FirstOrLastDay = $This.FirstOrLastDay.AddDays(1)
                }
            }
        }
        Return $This.FirstOrLastDay
    }
    
    static [String] IsItCoffeeTimeForLaurent () {

        $date = Get-Date
        $message = ''

        Switch ( $date ) {
            
            { ($PSitem.Hour - 21) -eq 0 } {
                Switch ( $date.Minute ) {
                    { $PSitem -in (0..8) } { $Message = "Now is the Time !! "}
                    { $PSitem -in (9..15) } { $Message = "Almost too late! Please hurry !! "}
                    { $PSitem -in (16..59) } { $Message = "Now it's BEDTIME LAURENT !!"}
                }
            }

            { ($PSitem.Hour - 21) -eq -1 } {
                Switch ( $date.Minute ) {
                    { $PSitem -in (51..59) } { $Message = "A little early but anyway.. COFFEE TIME !! "}
                    { $PSitem -in (30..50) } { $Message = "Prepare yourself young MAN !"}
                    { $PSitem -in (1..29) }  { $Message = "Sniff.. Sniff .. Can you smell that??"}
                }
            }

            { ($PSitem.Hour - 21) -in (-22..-2) } { $Message = "Nope... "}
            { ($PSitem.Hour - 21) -in (1..3) } { $Message = "Ouch... Too late buddy !!"}
        }
        return $message
    }
}
