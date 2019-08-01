
$period = New-DMDate
$period.SetFirstDayAndLastDay()
Write-Output (Find-DMFirstOrLastDay -Date $period -Day Monday -Which First)