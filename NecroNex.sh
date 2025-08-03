#!/data/data/com.termux/files/usr/bin/bash

# ───────────────────────────────────────────────
# 🎯 Info Pembuat
CREATOR="NecroelPix"
DEVICE="Android"
TANGGAL=$(date +"%A, %d %B %Y")
JAM=$(date +"%H:%M:%S")

# ───────────────────────────────────────────────
# 🔁 Animasi Android + NecroNex
function logo_animasi() {
  for i in {1..2}; do
    clear
    echo -e "\e[32m"
    figlet -f slant "NecroNex"
    echo -e "\e[0m"
    echo -e "\e[90m⌛ Loading Interface...\e[0m"
    sleep 1
    clear
    echo -e "\e[32m"
    figlet -f slant "NecroNex"
    echo -e "\e[0m"
    echo -e "\e[90m⌛ Loading Modules...\e[0m"
    sleep 1
  done
}

# ───────────────────────────────────────────────
# 🎨 Menu UI
function show_menu() {
  clear
  logo_animasi
  echo -e "\e[36m╔══════════════════════════════╗"
  echo -e "║        📱  NecroNex Tools       ║"
  echo -e "╠══════════════════════════════╣"
  echo -e "║ [1] Download Media dari Link  ║"
  echo -e "║ [2] Tes Kecepatan Internet    ║"
  echo -e "║ [3] Cek Cuaca & Iklim         ║"
  echo -e "║ [4] Ubah Kualitas Media       ║"
  echo -e "║ [0] Keluar                    ║"
  echo -e "╚══════════════════════════════╝"
  echo -ne "\e[33mPilih opsi: \e[0m"
  read pilihan
  case $pilihan in
    1) download_media ;;
    2) tes_internet ;;
    3) cek_cuaca ;;
    4) convert_media ;;
    0) exit ;;
    *) echo "Opsi salah"; sleep 1; show_menu ;;
  esac
}

# ───────────────────────────────────────────────
# 📥 Download Semua Media
function download_media() {
  clear
  read -p "Masukkan Link: " link
  echo -e "\e[35m⏬ Mendownload dari $link ...\e[0m"
  python3 -c "
import os
from pytube import YouTube
yt = YouTube('$link')
yt.streams.filter(progressive=True, file_extension='mp4').order_by('resolution').desc().first().download()
print('Download selesai ✅')
"
  selesai_animasi
}

# 🌐 Tes Kecepatan Internet
function tes_internet() {
  clear
  echo -e "\e[34m🌐 Mengecek kecepatan...\e[0m"
  curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python
  selesai_animasi
}

# ☁️ Cek Cuaca
function cek_cuaca() {
  clear
  read -p "Masukkan nama kota: " kota
  curl -s "https://wttr.in/${kota}?0" | head -n 20
  selesai_animasi
}

# 🔄 Konversi Media
function convert_media() {
  clear
  read -p "Masukkan path file: " file
  read -p "Resolusi (contoh: 1920x1080): " res
  output="converted_$(basename $file)"
  echo -e "\e[36m⚙️ Mengkonversi ke $res...\e[0m"
  ffmpeg -i "$file" -vf scale=$res "$output"
  echo "Output disimpan sebagai $output"
  selesai_animasi
}

# 🧨 Animasi Selesai
function selesai_animasi() {
  echo -e "\e[32m"
  figlet -f digital "Terima Kasih"
  echo -e "\e[0m"
  echo -e "✅ Proses selesai!"
  echo -e "📆 Tanggal: $TANGGAL"
  echo -e "🕘 Jam: $JAM"
  echo -e "💻 Dibuat oleh: $CREATOR | $DEVICE"
  echo -e ""
  read -p "Tekan Enter untuk kembali ke menu..."
  show_menu
}

# 🚀 Mulai
show_menu
