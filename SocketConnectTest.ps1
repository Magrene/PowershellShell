$port = 2020
$endpoint = new-object System.Net.IPEndPoint ([IPAddress]::Any,$port)
$udpclient = new-Object System.Net.Sockets.UdpClient $port
$content = $udpclient.Receive([ref]$endpoint)
[Text.Encoding]::ASCII.GetString($content)