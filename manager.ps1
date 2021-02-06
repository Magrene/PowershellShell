$stopwatch = [system.diagnostics.stopwatch]::StartNew()
Write-Output '-=--------------------------------=-'
Write-Output '-==-----------=-----=------------==-'
Write-Output '-===-----------=-=-=------------===-'
Write-Output '-====-----------===------------====-'
Write-Output '-=====-=====----===-========--=====-'
Write-Output '-=====-=   =----===-==-==-==--=====-'
Write-Output '-=====-=====----===-=--==--=--=====-'
Write-Output '-=====-=----=---===-=--==--=--=====-'
Write-Output '-=====-=-----=--===-=--==--=--=====-'
Write-Output '-=====-=------=-===-=--==--=--=====-'
$ftp = cat -path .\ftp.txt
$ADDS = cat -path .\ADDS.txt
$WIN10 = cat -path .\client.txt
$targetIP=@()
$data = cat -Path .\MachineDirectory.txt

[string]$userName = 'virus\magrene'
[string]$userPassword = 'Tossking123@'
[SecureString]$secureString = $userPassword | ConvertTo-SecureString -AsPlainText -Force 
[PSCredential]$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $userName, $secureString
function callRemote{
Foreach($i in $data){
    $currentTeam = $i.substring(0,5) 
    Write-Output $i
        $cmd = read-host
        ($er = ($output=Invoke-Command $i -Credential $credential -ArgumentList $cmd -ScriptBlock {$args[0]}) 2>&1) | Out-Null
        Write-Output $output
        if($er.Exception){
            
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

function allHost{
    Write-Output 'Please enter a command to distribute.'
    $cmd = read-host
    Foreach($i in $data){
        $currentTeam = $i.substring(0,5) 
            Write-Output $i
            ($er = ($output=(Invoke-Command $i -Credential $credential -ArgumentList $cmd -ScriptBlock {invoke-expression $args[0]})) 2>&1)
            
            
            if($er.Exception){
                $targetIP=@()
                Write-Output ('Failed to contact ' + $i)
                Foreach($z in $data){
                    if($z.substring(0,5) -eq $i.substring(0,5) -and $i -ne $z) {
                        if($targetIP -notcontains $z){
                            $targetIP += $z          
                            foreach($x in $targetIP){
                            
                                Write-Output ('Machine at ' + $x + ' executing command on machine ' + $i)
                                invoke-command $x -Credential $credential -ArgumentList $i , $credential , $cmd -ScriptBlock{invoke-command $args[0] -Credential $args[1] -ArgumentList $args[3] -ScriptBlock{invoke-expression $args[0]}} 
                            }
                        }

                    }
                
                
                }
       
            }
    }    

}

function TargetTeam{
    $targetIP=@()
    $TargetTeam = read-host 'Target Team: '
    $TargetTeam = ('10.' + $TargetTeam + '.')
    Write-Output 'Please enter a command to distribute.'
    $cmd = read-host
    Write-Output '----Executing----' 
    Foreach($i in $data){
        if($i.Substring(0,5) -eq $TargetTeam){
            $targetIP += $i
    }            
    }    
    foreach($z in $targetIP){
            write-output $z
            ($er = ($output=(Invoke-Command $z -Credential $credential -ArgumentList $cmd -ScriptBlock {invoke-expression $args[0]})) 2>&1)
            if($er.Exception){
                
                $targetIPF=@()
                Write-Output ('Failed to contact ' + $i)
                Foreach($z in $data){
                    if($z.substring(0,5) -eq $i.substring(0,5) -and $i -ne $z) {
                        if($targetIP -notcontains $z){
                            $targetIPF += $z          
                            foreach($x in $targetIPF){
                            
                                Write-Output ('Machine at ' + $x + ' executing command on machine ' + $i)
                                invoke-command $x -Credential $credential -ArgumentList $i , $credential , $cmd -ScriptBlock{invoke-command $args[0] -Credential $args[1] -ArgumentList $args[3] -ScriptBlock{invoke-expression $args[0]}} 
                            }
                        }

                    }
                
                
                }
            
            }
    }
}
function psSession{
    $TargetTeam = read-host 'Target Team'
    $TargetTeam = ('10.' + $TargetTeam + '.')
    $TargetHost = read-host 'FTP, ADDS, Windows Client'
    if($TargetHost -eq 'FTP'){
        Enter-PSSession ($TargetTeam + '2.4') -Credential $credential

    }
    elseif($TargetHost -eq 'ADDS'){
        Enter-PSSession ($TargetTeam + '1.60') -Credential $credential
    }
    else{
        Enter-PSSession ($TargetTeam + '1.70') -Credential $credential 
    }
    
}

function TargetHostType{
    $targetIP=@()
    $TargetHost = read-host 'Target Host Type: '
        
    Write-Output 'Please enter a command to distribute.'
    $cmd = read-host
    if($TargetHost -eq "FTP"){$TargetHosts = $FTP}
    elseif($TargetHost -eq "ADDS"){$TargetHosts = $ADDS}
    else{$TargetHosts = $WIN10}
    
    Write-Output '----Executing----' 
   
    foreach($z in $targetHosts){
            write-output $z
            ($er = ($output=(Invoke-Command $z -Credential $credential -ArgumentList $cmd -ScriptBlock {invoke-expression $args[0]})) 2>&1)
            
            if($er.Exception){
                
                $targetIPF=@()
                Write-Output ('Failed to contact ' + $i)
                Foreach($z in $data){
                    if($z.substring(0,5) -eq $i.substring(0,5) -and $i -ne $z) {
                        if($targetIP -notcontains $z){
                            $targetIPF += $z          
                            foreach($x in $targetIPF){
                            
                                Write-Output ('Machine at ' + $x + ' executing command on machine ' + $i)
                                invoke-command $x -Credential $credential -ArgumentList $i , $credential , $cmd -ScriptBlock{invoke-command $args[0] -Credential $args[1] -ArgumentList $args[3] -ScriptBlock{invoke-expression $args[0]}} 
                            }
                        }

                    }
                
                
                }
            
            }
    }
}
function Menus{
        $control = 1
        $f = 1
        
            Write-Output '-==================================-'
            write-output 'Select an option'
            write-output '(1) Issue a command to all hosts.'
            Write-Output '(2) Issue a command to all hosts of a speific team.'
            Write-Output '(3) Issue a command to all hosts of a type.'
            Write-Output '(4) Spawn an interactive shell.'

            $input = read-host 
            if($input -eq 4){
                psSession
            }
            elseif($input -eq 1){
                allHost
            }
            elseif($input -eq 2){
                TargetTeam
            }
            elseif($input -eq 3){
                TargetHostType
            }
        

        
    

}


Menus
#$domainSystemInfo = get-adcomputer -filter * -Properties ipv4address | select ipv4address , dnshostname