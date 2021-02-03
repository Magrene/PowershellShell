$data = cat -Path C:\Users\AnthonyM\Documents\GitHub\PowershellShell\MachineDirectory.txt
$credenital = Get-Credential
Foreach($i in $data){
    new-pssession $i -Credential $credenital
    $id = Get-PSSession | Where-Object {$_.ComputerName -eq $i} | select id
    Enter-PSSession $id

}

#$domainSystemInfo = get-adcomputer -filter * -Properties ipv4address | select ipv4address , dnshostname