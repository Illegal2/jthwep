<?php
date_default_timezone_set('Europe/Istanbul'); // Zaman dilimini ayarla

// Terminal Renk Kodları
$RED = "\033[0;31m";
$GREEN = "\033[0;32m";
$YELLOW = "\033[0;33m";
$CYAN = "\033[0;36m";
$RESET = "\033[0m";

// PHP Dahili Sunucu Aç
$host = "localhost";
$port = 8000;
$site_link = "http://$host:$port";

echo "{$GREEN}PHP Sunucu Başlatıldı! {$RESET}\n";
echo "{$YELLOW}Site Linki: {$CYAN}$site_link{$RESET}\n";
echo "{$CYAN}Mesajlar buraya düşecek...{$RESET}\n";

// Terminali Temizle ve Dinlemeye Başla
ob_implicit_flush(true);
ob_end_flush();

$server = stream_socket_server("tcp://$host:$port", $errno, $errstr);
if (!$server) {
    die("Sunucu başlatılamadı: $errstr ($errno)\n");
}

// Sonsuz Döngü: Gelen Bağlantıları Dinle
while ($client = @stream_socket_accept($server, -1)) {
    $request = fread($client, 1024);
    
    // POST Verisini Al
    preg_match('/msg=(.*?)&/', $request, $matches);
    $message = isset($matches[1]) ? urldecode($matches[1]) : "";

    // Kullanıcı IP Adresi
    preg_match('/X-Forwarded-For: (.*?)\r\n/', $request, $ip);
    $ip_address = isset($ip[1]) ? $ip[1] : "Bilinmiyor";

    // Saat ve Tarih
    $saat = date("H:i");
    $tarih = date("d/m/y");

    // Terminal Çıktısı
    echo "{$CYAN}SAAT={$GREEN}$saat {$RESET}\n";
    echo "{$CYAN}TARİH={$GREEN}$tarih {$RESET}\n";
    echo "{$CYAN}IP={$GREEN}$ip_address {$RESET}\n";
    echo "{$CYAN}SİTE={$YELLOW}$site_link {$RESET}\n";
    echo "{$CYAN}METİN={$RED}$message {$RESET}\n\n";

    // Eğer mesaj "Joker" ise sunucuyu kapat
    if (trim(strtolower($message)) === "joker") {
        echo "{$RED}Sunucu Kapatılıyor...{$RESET}\n";
        fclose($client);
        fclose($server);
        exit;
    }

    // HTML Sayfası Gönder
    fwrite($client, "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
    fwrite($client, '<!DOCTYPE html>
    <html lang="tr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Terminal Bağlantısı</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
                text-align: center;
            }
            .container {
                width: 100%;
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            h1 {
                color: #333;
                font-size: 24px;
            }
            input[type="text"] {
                width: 80%;
                padding: 10px;
                font-size: 16px;
                border: 2px solid #ddd;
                border-radius: 4px;
                margin-bottom: 20px;
                outline: none;
            }
            input[type="text"]:focus {
                border-color: #4CAF50;
            }
            button {
                padding: 10px 20px;
                font-size: 16px;
                color: white;
                background-color: #4CAF50;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Mesajınızı Girin</h1>
            <form method="GET">
                <input type="text" name="msg" placeholder="Mesajınızı yazın" required>
                <button type="submit">Gönder</button>
            </form>
        </div>
    </body>
    </html>');

    fclose($client);
}
?>
