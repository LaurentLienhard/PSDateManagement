$result = New-DMDate
$result.SetFirstDayAndLastDay()
Write-host ($result.FindFirstOrLastDay([System.DayOfWeek]::Saturday, "First"))

$result = New-DMDate -Date ((get-date).AddMonths(1))
$result.SetFirstDayAndLastDay()
Write-host ($result.FindFirstOrLastDay([System.DayOfWeek]::Saturday, "First"))

$result = New-DMDate -StartDate ((get-date).AddMonths(-6)) -EndDate ((get-date))
Write-host ($result.FindFirstOrLastDay([System.DayOfWeek]::Saturday, "First"))