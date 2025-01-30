#!/bin/bash

# Colores para el menú
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # Sin color

# Mostrar INFO SERVER
function info_server() {
    echo -e "${RED}INFO SERVER${NC}"
    echo -e "System Uptime  : $(uptime -p)"
    echo -e "Memory Usage   : $(free -h | awk '/Mem:/ {print $3 " / " $2}')"
    echo -e "VPN Core       : XRAY-CORE"
    echo -e "Domain         : $(hostname -f)"
    echo -e "IP VPS         : $(curl -s ifconfig.me)"
    echo -e "XRAY-CORE      : ${GREEN}ON${NC}"
    echo -e "NGINX          : ${GREEN}ON${NC}"
    echo
}

# Mostrar Tráfico de Red
function traffic_info() {
    echo -e "${CYAN}SSH XRAY WEBSOCKET MULTIPORT BY VINSTECHMY${NC}"
    echo -e "${BLUE}Traffic       Today        Yesterday       Month${NC}"
    echo -e "Download      998.61 M     25.36 G         51.23 G"
    echo -e "Upload        870.69 M     25.87 G         1.83 G"
    echo -e "Total         1.83 G       51.23 G         1.83 G"
    echo
}

# Instalación de dependencias básicas
function install_dependencies() {
    echo -e "${GREEN}Instalando dependencias necesarias...${NC}"
    apt update
    apt install -y curl wget unzip jq net-tools
    echo -e "${GREEN}Dependencias instaladas.${NC}"
}

# Menú AUTOSCRIPT
function autoscript_menu() {
    echo -e "${RED}AUTOSCRIPT MENU${NC}"
    echo -e "[1] XRAY Vmess WebSocket Panel"
    echo -e "[2] XRAY Vless WebSocket Panel"
    echo -e "[3] XRAY Trojan WebSocket Panel"
    echo -e "[4] SSH WebSocket Panel"
}

# Menú SYSTEM
function system_menu() {
    echo -e "${RED}SYSTEM MENU${NC}"
    echo -e "[5] Change Domain"
    echo -e "[6] Renew Certificate XRAY"
    echo -e "[7] Check VPN Status"
    echo -e "[8] Check VPN Port"
    echo -e "[9] Restart VPN Services"
    echo -e "[10] Speedtest VPS"
    echo -e "[11] Check RAM"
    echo -e "[12] Check Bandwidth"
    echo -e "[13] DNS Changer"
    echo -e "[14] Netflix Checker"
    echo -e "[15] Backup"
    echo -e "[16] Restore"
    echo -e "[17] Reboot"
}

# Función principal
function main_menu() {
    while true; do
        clear
        info_server
        traffic_info
        autoscript_menu
        system_menu
        echo -e "Press [${GREEN}Ctrl+C${NC}] To-Exit-Script
