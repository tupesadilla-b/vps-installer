#!/bin/bash

# Colores para el menú
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Función para mostrar estadísticas del servidor
function server_info() {
    echo -e "${RED}INFO SERVER${NC}"
    echo -e "System Uptime: $(uptime -p)"
    echo -e "Memory Usage: $(free -h | awk '/Mem:/ {print $3 " / " $2}')"
    echo -e "VPN Core: XRAY-CORE"
    echo -e "Domain: $(hostname -f)"
    echo -e "IP VPS: $(curl -s ifconfig.me)"
}

# Función para instalar dependencias
function install_dependencies() {
    echo -e "${GREEN}Instalando dependencias...${NC}"
    apt update
    apt install -y curl wget git unzip jq net-tools
    # Instalar XRAY
    bash <(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)
    echo -e "${GREEN}Dependencias instaladas.${NC}"
}

# Función para renovar certificados
function renew_certificates() {
    echo -e "${BLUE}Renovando certificados XRAY...${NC}"
    # Añade aquí los comandos específicos para renovar certificados
    echo "Certificados renovados correctamente."
}

# Función para cambiar el dominio
function change_domain() {
    read -p "Ingrese el nuevo dominio: " new_domain
    echo "Cambiando el dominio a $new_domain..."
    # Añade aquí los comandos necesarios para cambiar el dominio
    echo "Dominio cambiado a $new_domain."
}

# Función para reiniciar servicios
function restart_services() {
    echo -e "${BLUE}Reiniciando servicios de VPN...${NC}"
    systemctl restart xray
    echo "Servicios reiniciados."
}

# Menú principal
function main_menu() {
    while true; do
        clear
        server_info
        echo -e "${RED}AUTOSCRIPT MENU${NC}"
        echo -e "[1] Instalar dependencias"
        echo -e "[2] Renovar certificados XRAY"
        echo -e "[3] Cambiar dominio"
        echo -e "[4] Reiniciar servicios VPN"
        echo -e "[5] Salir"
        echo -n "Seleccione una opción: "
        read opt
        case $opt in
            1) install_dependencies ;;
            2) renew_certificates ;;
            3) change_domain ;;
            4) restart_services ;;
            5) exit 0 ;;
            *) echo -e "${RED}Opción no válida.${NC}" ;;
        esac
        read -p "Presione Enter para continuar..."
    done
}

# Ejecutar el menú principal
main_menu
