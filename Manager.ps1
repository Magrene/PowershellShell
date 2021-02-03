$data = cat -Path C:\Users\AnthonyM\Documents\GitHub\PowershellShell\MachineDirectory.txt
$credenital = Get-Credential
Foreach($i in $data){
    new-pssession $i -Credential $credenital
    invoke-command -ComputerName $i -Credential $credenital -ScriptBlock { 
        get-adcomputer -filter * -Properties ipv4address | select ipv4address , dnshostname
    } | out-file ($i.substring(3,4) + ' TeamInfo')


}

#$domainSystemInfo = get-adcomputer -filter * -Properties ipv4address | select ipv4address , dnshostname