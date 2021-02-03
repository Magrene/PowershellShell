$data = cat -Path C:\Users\AnthonyM\Documents\GitHub\PowershellShell\MachineDirectory.txt
$credenital = Get-Credential

function getDomainStructure{
    Foreach($i in $data){
        new-pssession $i -Credential $credenital
        $ip = Get-NetIPAddress | select ipaddress | Where-Object {$_.ipaddress -eq '10.*'}
        if($ip -eq '*1.60*'){
            invoke-command -ComputerName $i -Credential $credenital -ScriptBlock { 
                get-adcomputer -filter * -Properties ipv4address | select ipv4address , dnshostname
            } | out-file ($i.substring(3,4) + ' TeamInfo')
        }

    }
}

getDomainStructure

#$domainSystemInfo = get-adcomputer -filter * -Properties ipv4address | select ipv4address , dnshostname