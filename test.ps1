
$result = New-DMDate
$result.SetFirstDayAndLastDay()
Write-Output (Find-FirstOrLastDay -Date $result -Day Monday -Which First)