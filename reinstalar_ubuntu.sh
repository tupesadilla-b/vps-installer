#!/bin/bash

# Advertencia antes de ejecutar
echo "⚠ ADVERTENCIA: Este script eliminará TODOS los archivos y reinstalará Ubuntu."
read -p "¿Estás seguro de continuar? (escribe 'CONFIRMAR' para proceder): " confirmacion

if [ "$confirmacion" != "CONFIRMAR" ]; then
    echo "Operación cancelada."
    exit 1
fi

# Definir la versión de Ubuntu a instalar
UBUNTU_VERSION="jammy"  # Ubuntu 22.04 LTS

# Identificar el disco principal
DISCO=$(lsblk -ndo PKNAME $(df / | tail -1 | awk '{print $1}'))
DISCO="/dev/$DISCO"

echo "El disco identificado es: $DISCO"
echo "Formateando y reinstalando Ubuntu $UBUNTU_VERSION..."

# Desmontar particiones activas
swapoff -a
umount -l /mnt 2>/dev/null

# Borrar tabla de particiones
wipefs -a $DISCO
parted -s $DISCO mklabel gpt
parted -s $DISCO mkpart primary ext4 1MiB 100%

# Formatear la nueva partición
mkfs.ext4 "${DISCO}1"

# Montar la partición en /mnt
mount "${DISCO}1" /mnt

# Instalar Ubuntu básico con debootstrap
apt update && apt install -y debootstrap grub-pc
debootstrap --arch=amd64 $UBUNTU_VERSION /mnt http://archive.ubuntu.com/ubuntu/

# Configurar fstab
echo "UUID=$(blkid -s UUID -o value ${DISCO}1) / ext4 defaults 0 1" > /mnt/etc/fstab

# Configurar GRUB
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
chroot /mnt grub-install $DISCO
chroot /mnt update-grub

# Configurar hostname y red
echo "ubuntu-vps" > /mnt/etc/hostname
echo "127.0.1.1 ubuntu-vps" >> /mnt/etc/hosts

# Crear usuario root con contraseña "root"
chroot /mnt bash -c "echo 'root:root' | chpasswd"

# Desmontar todo antes de reiniciar
umount -l /mnt/dev /mnt/proc /mnt/sys
umount -l /mnt

echo "✅ Instalación completada. Reiniciando en 10 segundos..."
sleep 10
reboot
