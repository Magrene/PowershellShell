$peerport=2020
##Client
[console]::Title = ("Server: $env:Computername <{0}>" -f `
[net.dns]::GetHostAddresses($env:Computername))[0].IPAddressToString
$port=1655
$server='Boe-PC'
$client = New-Object System.Net.Sockets.TcpClient $server, $port