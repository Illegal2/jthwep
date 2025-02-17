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
    </head>
    <body style="text-align:center; font-family:Arial; margin-top:100px;">
        <form method="GET">
            <input type="text" name="msg" placeholder="Mesajınızı yazın" required>
            <button type="submit">Gönder</button>
        </form>
    </body>
    </html>');

    fclose($client);
}
?>
