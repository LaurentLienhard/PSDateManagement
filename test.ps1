$result = [DATE]::new(((get-date).AddDays((-16))), (get-date))
$result = New-DMDate -StartDate ((get-date).AddMonths((-1))) -EndDate (get-date)
$result = New-DMDate
$result.SetFirstDateAndLastDateOfMonth()
$result.NumberOFWorkingDays()