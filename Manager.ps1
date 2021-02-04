$data = cat -Path C:\Users\AnthonyM\Documents\GitHub\PowershellShell\MachineDirectory.txt
[string]$userName = 'virus\magrene'
[string]$userPassword = 'Tossking123@'


[SecureString]$secureString = $userPassword | ConvertTo-SecureString -AsPlainText -Force 
[PSCredential]$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $userName, $secureString
Foreach($i in $data){
    Write-Output $i
    Invoke-Command $i -Credential $credential -ScriptBlock {hostname}
}

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



#$domainSystemInfo = get-adcomputer -filter * -Properties ipv4address | select ipv4address , dnshostname