$port = 2020
$ip = '127.0.0.1'
##Server
[console]::Title = ("Server: $env:Computername <{0}> on $port" -f `
[net.dns]::GetHostAddresses($env:Computername))[0].IPAddressToString
$port=1655
$endpoint = new-object System.Net.IPEndPoint ([system.net.ipaddress]::any, $port)
$listener = new-object System.Net.Sockets.TcpListener $endpoint
$listener.start()
$client = $listener.AcceptTcpClient()