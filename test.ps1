$result = New-DMDate
$result.SetFirstDayAndLastDay()
Write-host ($result.FindFirstOrLastDayInMonth([System.DayOfWeek]::Saturday, "First"))

$result = New-DMDate -Date ((get-date).AddMonths(1))
$result.SetFirstDayAndLastDay()
Write-host ($result.FindFirstOrLastDayInMonth([System.DayOfWeek]::Saturday, "First"))