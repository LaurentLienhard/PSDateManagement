
$period = New-DMDate
$period.SetFirstDayAndLastDay()
Write-Output (Find-FirstOrLastDay -Date $period -Day Monday -Which First)