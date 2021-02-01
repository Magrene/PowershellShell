$port = 2020
$ip = '127.0.0.1'
$tcpClient = new-Object System.Net.Sockets.TcpClient ($ip,$port)
$tcpStream = $tcpClient.GetStream()
$reader = New-Object System.IO.StreamReader($tcpStream)
$writer = New-Object System.IO.StreamWriter($tcpStream)
$write.autoFlush = $true

$buffer = New-Object System.Byte[] 1024
$encoding = new-object System.Text.ASCIIEncoding

while ($tcpClient.Connected)
{
    while ($tcpStream.DataAvailable)
    {

        $rawresponse = $reader.Read($buffer, 0, 1024)
        $response = $encoding.GetString($buffer, 0, $rawresponse)   
    }

    if ($tcpClient.Connected)
    {
        Write-Host -NoNewline "prompt> "
        $command = Read-Host

        if ($command -eq "escape")
        {
            break
        }

        $writer.WriteLine($command) | Out-Null
    }
    start-sleep -Milliseconds 500
}

$reader.Close()
$writer.Close()
$tcpClient.Close()
