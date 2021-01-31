$peerport=2020
$peerip=127.0.0.1
$client = new-object net.sockets.udpclient(0)
$send = [text.encoding]::ascii.getbytes("heyo")
[void] $client.send($send, $send.length, $peerIP, $peerPort)