$data = cat -Path .\MachineDirectory.txt
[string]$userName = 'virus\magrene'
[string]$userPassword = 'Tossking123@'

[SecureString]$secureString = $userPassword | ConvertTo-SecureString -AsPlainText -Force 
[PSCredential]$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $userName, $secureString
Foreach($i in $data){
    $currentTeam = $i.substring(0,5) 
    Write-Output $i
       
        ($er = ($output=Invoke-Command $i -Credential $credential -ScriptBlock {hostname}) 2>&1) | Out-Null
        Write-Output $output
        if($er.Exception){
            $targetIP=@()
            Write-Output ('Failed to contact ' + $i)
            Foreach($z in $data){
                if($z.substring(0,5) -eq $i.substring(0,5) -and $i -ne $z) {
                    if($targetIP -notcontains $z){
                        $targetIP += $z          
                        foreach($x in $targetIP){
                            
                            Write-Output ('Machine at ' + $x + ' executing command on machine ' + $i)
                            invoke-command $x -Credential $credential -ArgumentList $i , $credential -ScriptBlock{invoke-command $args[0] -Credential $args[1] -ScriptBlock{hostname}} 
                        }
                    }

                }
                
                
            }
       
        }
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