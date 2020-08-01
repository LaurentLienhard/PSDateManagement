<#
$period = New-DMDate
$period.SetFirstDayAndLastDay()
Write-Output (Find-DMFirstOrLastDay -Date $period -Day Monday -Which First) #>


$NewDate = New-DMDate -Date (get-date)
$NewDate.ConvertTimeZone($NewDate.aDate, "W. Europe Standard Time", "US Eastern Standard Time" )