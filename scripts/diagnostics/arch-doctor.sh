#!/usr/bin/env bash

# ====================================
# Linux Dev Setup - Arch Doctor
# ====================================
# Diagnóstico completo y NO destructivo de un sistema Arch Linux.
#
# El script solo lee información: no instala, no elimina, no modifica
# configuración y no ejecuta sudo. Cada hallazgo incluye el comando
# sugerido para que la corrección la decida y ejecute el usuario.
#
# Uso:
#   ./scripts/diagnostics/arch-doctor.sh                # informe en pantalla
#   ./scripts/diagnostics/arch-doctor.sh --report       # además guarda un .txt
#   ./scripts/diagnostics/arch-doctor.sh --no-color     # sin colores (para pegar en un issue)

set -uo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

SAVE_REPORT=0
REPORT_FILE=""

# Contadores del resumen final
COUNT_OK=0
COUNT_WARN=0
COUNT_FAIL=0
WARNINGS=()
FAILURES=()

parse_args() {
    for arg in "$@"; do
        case "$arg" in
            --report)
                SAVE_REPORT=1
                ;;
            --no-color)
                GREEN=''; RED=''; YELLOW=''; BLUE=''; CYAN=''; NC=''
                ;;
            -h|--help)
                sed -n '3,15p' "$0" | sed 's/^# \{0,1\}//'
                exit 0
                ;;
            *)
                echo "Opción desconocida: $arg (usa --help)"
                exit 1
                ;;
        esac
    done
}

print_header() {
    echo ""
    echo -e "${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}"
}

print_ok() {
    COUNT_OK=$((COUNT_OK + 1))
    echo -e "${GREEN}✓${NC} $1"
}

print_warn() {
    COUNT_WARN=$((COUNT_WARN + 1))
    WARNINGS+=("$1")
    echo -e "${YELLOW}⚠${NC} $1"
}

print_fail() {
    COUNT_FAIL=$((COUNT_FAIL + 1))
    FAILURES+=("$1")
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_fix() {
    echo -e "    ${CYAN}→ sugerencia:${NC} $1"
}

has() {
    command -v "$1" >/dev/null 2>&1
}

# Indenta la salida de un comando para diferenciarla de los mensajes del script
indent() {
    local line
    while IFS= read -r line; do
        printf '    %s\n' "$line"
    done
}

# ------------------------------------
# 1. Identidad del sistema
# ------------------------------------
check_system() {
    print_header "1. Sistema"

    if [ -r /etc/os-release ]; then
        # shellcheck disable=SC1091
        . /etc/os-release
        print_info "Distribución: ${PRETTY_NAME:-desconocida}"
        if [[ "${ID:-}" != "arch" && "${ID_LIKE:-}" != *arch* ]]; then
            print_warn "Este diagnóstico está pensado para Arch Linux; algunas comprobaciones se omitirán"
        fi
    else
        print_fail "No existe /etc/os-release, no se puede identificar la distribución"
    fi

    print_info "Kernel: $(uname -r)  |  Arquitectura: $(uname -m)"
    print_info "Hostname: $(uname -n)"
    has uptime && print_info "Uptime: $(uptime -p 2>/dev/null || uptime)"

    if [ -d /sys/firmware/efi ]; then
        print_info "Modo de arranque: UEFI"
    else
        print_info "Modo de arranque: BIOS/Legacy"
    fi

    # Un kernel instalado más nuevo que el que corre obliga a reiniciar antes de
    # cargar módulos nuevos (causa clásica de "module not found" en Arch).
    local running_kernel
    running_kernel="$(uname -r)"
    if [ ! -d "/usr/lib/modules/${running_kernel}" ]; then
        print_fail "Los módulos del kernel en ejecución (${running_kernel}) ya no existen en /usr/lib/modules"
        print_fix "reinicia el sistema antes de conectar hardware o cargar módulos nuevos"
    else
        print_ok "Los módulos del kernel en ejecución coinciden con los instalados"
    fi
}

# ------------------------------------
# 2. Hardware y recursos
# ------------------------------------
check_hardware() {
    print_header "2. Hardware y recursos"

    if has lscpu; then
        print_info "CPU: $(lscpu | awk -F': +' '/Model name/{print $2; exit}')"
    fi

    if has free; then
        print_info "Memoria: $(free -h | awk '/^Mem:/{print $3" usados de "$2" ("$7" disponibles)"}')"
        local swap_total
        swap_total=$(free -m | awk '/^Swap:/{print $2}')
        if [ "${swap_total:-0}" -eq 0 ]; then
            print_warn "No hay swap configurada (riesgo de OOM al compilar paquetes grandes)"
            print_fix "considera zram: sudo pacman -S zram-generator"
        else
            print_ok "Swap disponible: $(free -h | awk '/^Swap:/{print $2}')"
        fi
    fi

    if has lspci; then
        lspci | grep -Ei 'vga|3d|display' | while read -r line; do
            print_info "GPU: ${line#*: }"
        done
    fi

    if has sensors; then
        local temp
        temp=$(sensors 2>/dev/null | awk '/^(Package id 0|Tctl)/{print $NF; exit}')
        [ -n "$temp" ] && print_info "Temperatura CPU: $temp"
    fi

    if [ -d /sys/class/power_supply ]; then
        local bat
        for bat in /sys/class/power_supply/BAT*; do
            [ -d "$bat" ] || continue
            local cap health
            cap=$(cat "$bat/capacity" 2>/dev/null || echo "?")
            health=$(cat "$bat/status" 2>/dev/null || echo "?")
            print_info "Batería $(basename "$bat"): ${cap}% (${health})"
        done
    fi
}

# ------------------------------------
# 3. Almacenamiento
# ------------------------------------
check_storage() {
    print_header "3. Almacenamiento"

    # Espacio por punto de montaje relevante
    local mount used
    while read -r mount used; do
        if [ "$used" -ge 95 ]; then
            print_fail "Partición $mount al ${used}% de uso"
            print_fix "libera espacio antes de actualizar (pacman necesita espacio en /var y /)"
        elif [ "$used" -ge 85 ]; then
            print_warn "Partición $mount al ${used}% de uso"
        else
            print_ok "Partición $mount al ${used}% de uso"
        fi
    done < <(df -P -x tmpfs -x devtmpfs -x squashfs 2>/dev/null | awk 'NR>1 {gsub("%","",$5); print $6, $5}')

    # /boot pequeño y lleno rompe la instalación de kernels nuevos
    if mountpoint -q /boot 2>/dev/null; then
        local boot_used
        boot_used=$(df -P /boot | awk 'NR==2 {gsub("%","",$5); print $5}')
        if [ "${boot_used:-0}" -ge 80 ]; then
            print_warn "/boot al ${boot_used}%: una actualización de kernel puede fallar a medias"
            print_fix "revisa kernels antiguos e imágenes de initramfs en /boot"
        fi
    fi

    # Inodos agotados se presentan como "no space left" con espacio libre
    while read -r mount used; do
        if [ "$used" -ge 90 ]; then
            print_warn "Inodos de $mount al ${used}%"
        fi
    done < <(df -P -i -x tmpfs -x devtmpfs 2>/dev/null | awk 'NR>1 && $5 ~ /%/ {gsub("%","",$5); print $6, $5}')

    if has lsblk; then
        print_info "Discos y particiones:"
        lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS 2>/dev/null | indent
    fi

    # Errores de sistema de archivos en el arranque actual
    if has journalctl; then
        local fs_errors
        fs_errors=$(journalctl -b -p err --no-pager 2>/dev/null | grep -Eic 'ext4-fs error|btrfs.*error|xfs.*corruption|i/o error' || true)
        if [ "${fs_errors:-0}" -gt 0 ]; then
            print_fail "$fs_errors errores de sistema de archivos o E/S en el arranque actual"
            print_fix "journalctl -b -p err | grep -Ei 'fs error|i/o error'"
        else
            print_ok "Sin errores de sistema de archivos en el arranque actual"
        fi
    fi
}

# ------------------------------------
# 4. Salud de pacman (lo más crítico en Arch)
# ------------------------------------
check_pacman() {
    print_header "4. Pacman y paquetes"

    if ! has pacman; then
        print_warn "pacman no disponible; se omite el bloque de paquetes"
        return
    fi

    print_info "Paquetes instalados: $(pacman -Q 2>/dev/null | wc -l)"

    # Lock file olvidado tras un pacman interrumpido
    if [ -f /var/lib/pacman/db.lck ]; then
        print_fail "Existe /var/lib/pacman/db.lck: hay un pacman en curso o quedó un lock huérfano"
        print_fix "verifica con 'pgrep -a pacman'; si no hay proceso: sudo rm /var/lib/pacman/db.lck"
    else
        print_ok "Sin lock de base de datos de pacman"
    fi

    # Antigüedad de la última sincronización: un -Sy parcial rompe el sistema
    local sync_db days_old
    sync_db=$(find /var/lib/pacman/sync -maxdepth 1 -name '*.db' -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2-)
    if [ -n "$sync_db" ]; then
        days_old=$(( ( $(date +%s) - $(stat -c %Y "$sync_db") ) / 86400 ))
        if [ "$days_old" -ge 30 ]; then
            print_warn "La base de datos de repos tiene ${days_old} días"
            print_fix "sudo pacman -Syu   (nunca uses -Sy solo: provoca actualizaciones parciales)"
        else
            print_ok "Base de datos de repos sincronizada hace ${days_old} día(s)"
        fi
    fi

    # Fecha de la última actualización completa según el log
    if [ -r /var/log/pacman.log ]; then
        local last_upgrade
        last_upgrade=$(grep -a 'starting full system upgrade' /var/log/pacman.log 2>/dev/null | tail -1 | cut -d' ' -f1 | tr -d '[]')
        [ -n "$last_upgrade" ] && print_info "Última actualización completa: $last_upgrade"
    fi

    # Actualizaciones pendientes sin tocar la base de datos (checkupdates usa una copia)
    if has checkupdates; then
        local pending
        pending=$(checkupdates 2>/dev/null | wc -l)
        if [ "$pending" -gt 0 ]; then
            print_warn "$pending actualizaciones pendientes"
            print_fix "sudo pacman -Syu   (revisa antes https://archlinux.org/news/)"
        else
            print_ok "Sistema al día respecto a los repos oficiales"
        fi
    else
        print_info "Instala 'pacman-contrib' para consultar actualizaciones sin modificar la base de datos"
    fi

    # Paquetes huérfanos
    local orphans
    orphans=$(pacman -Qtdq 2>/dev/null | wc -l)
    if [ "$orphans" -gt 0 ]; then
        print_warn "$orphans paquetes huérfanos (dependencias que ya nadie usa)"
        print_fix "revísalos con 'pacman -Qtdq' antes de eliminar nada"
    else
        print_ok "Sin paquetes huérfanos"
    fi

    # Paquetes foráneos (AUR o instalados a mano): no reciben actualizaciones de los repos
    local foreign
    foreign=$(pacman -Qmq 2>/dev/null | wc -l)
    if [ "$foreign" -gt 0 ]; then
        print_info "$foreign paquetes foráneos/AUR: $(pacman -Qmq 2>/dev/null | tr '\n' ' ')"
        print_info "Los paquetes AUR no se actualizan con pacman -Syu; requieren tu helper o rebuild manual"
    else
        print_ok "Sin paquetes foráneos instalados"
    fi

    # Archivos .pacnew / .pacsave sin fusionar: configuración desactualizada silenciosa
    local pacnew
    pacnew=$(find /etc -name '*.pacnew' -o -name '*.pacsave' 2>/dev/null | wc -l)
    if [ "$pacnew" -gt 0 ]; then
        print_warn "$pacnew archivos .pacnew/.pacsave pendientes de revisar en /etc"
        print_fix "find /etc -name '*.pacnew' -o -name '*.pacsave'   (fusiona con pacdiff, de pacman-contrib)"
    else
        print_ok "Sin archivos .pacnew/.pacsave pendientes"
    fi

    # Tamaño de la caché de paquetes
    if [ -d /var/cache/pacman/pkg ]; then
        local cache_size
        cache_size=$(du -sh /var/cache/pacman/pkg 2>/dev/null | cut -f1)
        print_info "Caché de paquetes: ${cache_size:-desconocido}"
        print_info "Para limpiarla de forma segura: paccache -rk2 (conserva las 2 últimas versiones)"
    fi

    # Keyring: si caduca, todas las instalaciones fallan con "unknown trust"
    if has pacman-key; then
        if [ -d /etc/pacman.d/gnupg ]; then
            print_ok "Keyring de pacman presente en /etc/pacman.d/gnupg"
        else
            print_fail "Falta /etc/pacman.d/gnupg: pacman no podrá verificar firmas"
            print_fix "sudo pacman-key --init && sudo pacman-key --populate archlinux"
        fi
    fi

    # Mirrorlist
    if [ -r /etc/pacman.d/mirrorlist ]; then
        local mirrors
        mirrors=$(grep -c '^Server' /etc/pacman.d/mirrorlist 2>/dev/null || echo 0)
        if [ "$mirrors" -eq 0 ]; then
            print_fail "No hay ningún mirror activo en /etc/pacman.d/mirrorlist"
            print_fix "regenera la lista con reflector o desde archlinux.org/mirrorlist"
        else
            print_ok "$mirrors mirrors activos"
        fi
    fi

    # Repos de terceros: fuente habitual de conflictos y actualizaciones parciales
    if [ -r /etc/pacman.conf ]; then
        local third_party
        third_party=$(grep -oP '^\[\K[^]]+' /etc/pacman.conf 2>/dev/null \
            | grep -Ev '^(options|core|extra|multilib|community|testing|core-testing|extra-testing|multilib-testing)$' || true)
        if [ -n "$third_party" ]; then
            print_warn "Repositorios de terceros habilitados: $(echo "$third_party" | tr '\n' ' ')"
            print_info "Suelen ir por detrás de los repos oficiales y provocar conflictos de versiones"
        else
            print_ok "Solo repositorios oficiales habilitados"
        fi
    fi
}

# ------------------------------------
# 5. Integridad de archivos de paquetes
# ------------------------------------
check_integrity() {
    print_header "5. Integridad de paquetes"

    if ! has pacman; then
        print_info "pacman no disponible; se omite"
        return
    fi

    print_info "Comprobando archivos faltantes de los paquetes instalados (puede tardar)…"
    local broken
    broken=$(pacman -Qk 2>/dev/null | grep -v '0 missing files' | head -20)
    if [ -n "$broken" ]; then
        print_warn "Paquetes con archivos faltantes:"
        echo "$broken" | indent
        print_fix "reinstala el paquete afectado con 'sudo pacman -S <paquete>'"
    else
        print_ok "Todos los paquetes tienen sus archivos en su sitio"
    fi

    # Binarios enlazados a bibliotecas ya reemplazadas (típico tras actualizar mucho AUR)
    if has checkrebuild; then
        local rebuild
        rebuild=$(checkrebuild 2>/dev/null | head -10)
        if [ -n "$rebuild" ]; then
            print_warn "Paquetes que deberían recompilarse:"
            echo "$rebuild" | indent
        else
            print_ok "Ningún paquete necesita recompilarse"
        fi
    else
        print_info "Instala 'rebuild-detector' para detectar paquetes AUR enlazados a bibliotecas antiguas"
    fi
}

# ------------------------------------
# 6. systemd y servicios
# ------------------------------------
check_systemd() {
    print_header "6. systemd y servicios"

    if ! has systemctl; then
        print_info "systemd no disponible; se omite"
        return
    fi

    local state
    state=$(systemctl is-system-running 2>/dev/null || true)
    case "$state" in
        running)
            print_ok "Estado del sistema: running"
            ;;
        degraded)
            print_fail "Estado del sistema: degraded (hay unidades fallidas)"
            ;;
        *)
            print_warn "Estado del sistema: ${state:-desconocido}"
            ;;
    esac

    local failed
    failed=$(systemctl --failed --no-legend --plain 2>/dev/null | awk '{print $1}')
    if [ -n "$failed" ]; then
        print_fail "Unidades de sistema fallidas:"
        echo "$failed" | indent
        print_fix "systemctl status <unidad> && journalctl -u <unidad> -b"
    else
        print_ok "Sin unidades de sistema fallidas"
    fi

    local failed_user
    failed_user=$(systemctl --user --failed --no-legend --plain 2>/dev/null | awk '{print $1}')
    if [ -n "$failed_user" ]; then
        print_warn "Unidades de usuario fallidas: $(echo "$failed_user" | tr '\n' ' ')"
    fi

    # Servicios habilitados pero no arrancados
    local dead
    dead=$(systemctl list-unit-files --state=enabled --no-legend --plain 2>/dev/null | awk '{print $1}' \
        | while read -r unit; do
            case "$unit" in *.service) ;; *) continue ;; esac
            if [ "$(systemctl is-active "$unit" 2>/dev/null)" = "inactive" ]; then
                echo "$unit"
            fi
        done | head -10)
    if [ -n "$dead" ]; then
        print_info "Servicios habilitados que no están activos (normal si son oneshot):"
        echo "$dead" | indent
    fi

    if has systemd-analyze; then
        print_info "Tiempo de arranque: $(systemd-analyze time 2>/dev/null | head -1)"
    fi
}

# ------------------------------------
# 7. Registros y errores
# ------------------------------------
check_logs() {
    print_header "7. Registros del sistema"

    if ! has journalctl; then
        print_info "journalctl no disponible; se omite"
        return
    fi

    local errors
    errors=$(journalctl -b -p 3 --no-pager 2>/dev/null | wc -l)
    if [ "$errors" -gt 50 ]; then
        print_warn "$errors líneas de error en el arranque actual"
        print_fix "journalctl -b -p 3 --no-pager | tail -40"
    elif [ "$errors" -gt 0 ]; then
        print_info "$errors líneas de error en el arranque actual (revisables con journalctl -b -p 3)"
    else
        print_ok "Sin errores de prioridad alta en el arranque actual"
    fi

    # Errores más repetidos: suelen apuntar al problema real
    local top_errors
    top_errors=$(journalctl -b -p 3 --no-pager -o cat 2>/dev/null | sort | uniq -c | sort -rn | head -5)
    if [ -n "$top_errors" ]; then
        print_info "Errores más frecuentes:"
        echo "$top_errors" | indent
    fi

    if has coredumpctl; then
        local dumps
        dumps=$(coredumpctl list --no-pager --since "-7 days" 2>/dev/null | grep -c . || true)
        if [ "${dumps:-0}" -gt 1 ]; then
            print_warn "Hay volcados de memoria en los últimos 7 días (procesos que crashearon)"
            print_fix "coredumpctl list --since '-7 days'"
        fi
    fi

    local journal_size
    journal_size=$(journalctl --disk-usage 2>/dev/null | grep -oP '[0-9.]+[KMG]' | tail -1)
    [ -n "$journal_size" ] && print_info "Tamaño del journal: $journal_size"
}

# ------------------------------------
# 8. Arranque, initramfs y drivers
# ------------------------------------
check_boot() {
    print_header "8. Arranque, initramfs y drivers"

    # Un initramfs más viejo que el kernel indica un mkinitcpio que no se ejecutó
    local kver img
    kver=$(uname -r)
    for img in /boot/initramfs-*.img /boot/initrd.img-*; do
        [ -f "$img" ] || continue
        local vmlinuz="/boot/vmlinuz-linux"
        if [ -f "$vmlinuz" ] && [ "$vmlinuz" -nt "$img" ]; then
            print_warn "$(basename "$img") es más antiguo que el kernel instalado"
            print_fix "sudo mkinitcpio -P"
        fi
    done

    if has bootctl && [ -d /sys/firmware/efi ]; then
        local esp_used
        if mountpoint -q /boot/efi 2>/dev/null || mountpoint -q /efi 2>/dev/null || mountpoint -q /boot 2>/dev/null; then
            esp_used=$(df -P /boot 2>/dev/null | awk 'NR==2 {print $5}')
            print_info "Partición de arranque en uso: ${esp_used:-desconocido}"
        fi
    fi

    # Módulos DKMS sin compilar para el kernel actual (VirtualBox, NVIDIA, etc.)
    if has dkms; then
        local dkms_bad
        dkms_bad=$(dkms status 2>/dev/null | grep -v 'installed' | head -5)
        if [ -n "$dkms_bad" ]; then
            print_warn "Módulos DKMS no instalados para el kernel actual:"
            echo "$dkms_bad" | indent
            print_fix "sudo dkms autoinstall -k $kver"
        else
            print_ok "Módulos DKMS al día"
        fi
    fi

    # Firmware faltante: causa típica de Wi-Fi o GPU que no arrancan
    if has journalctl; then
        local fw_missing
        fw_missing=$(journalctl -b -k --no-pager 2>/dev/null | grep -Eio 'firmware: failed to load [a-z0-9_./-]+' | sort -u | head -5)
        if [ -n "$fw_missing" ]; then
            print_warn "Firmware que no se pudo cargar:"
            echo "$fw_missing" | indent
            print_fix "suele resolverse instalando 'linux-firmware' o el paquete de firmware del fabricante"
        else
            print_ok "Sin firmware faltante en el arranque actual"
        fi
    fi
}

# ------------------------------------
# 9. Red
# ------------------------------------
check_network() {
    print_header "9. Red"

    if has ip; then
        local up_ifaces
        up_ifaces=$(ip -brief link show up 2>/dev/null | awk '$1 != "lo" {print $1}' | tr '\n' ' ')
        if [ -n "$up_ifaces" ]; then
            print_ok "Interfaces activas: $up_ifaces"
        else
            print_fail "No hay interfaces de red activas"
        fi
        ip -brief address show 2>/dev/null | indent
    fi

    if has resolvectl; then
        print_info "DNS: $(resolvectl status 2>/dev/null | awk '/DNS Servers/{$1="";$2="";print;exit}' | xargs)"
    elif [ -r /etc/resolv.conf ]; then
        print_info "DNS: $(awk '/^nameserver/{printf "%s ", $2}' /etc/resolv.conf)"
    fi

    if has ping; then
        if ping -c1 -W2 1.1.1.1 >/dev/null 2>&1; then
            print_ok "Conectividad IP correcta"
        else
            print_warn "Sin respuesta al hacer ping a 1.1.1.1 (puede estar bloqueado el ICMP)"
        fi
    fi

    if has getent; then
        if getent hosts archlinux.org >/dev/null 2>&1; then
            print_ok "Resolución DNS correcta"
        else
            print_fail "La resolución DNS falla"
            print_fix "revisa /etc/resolv.conf y el estado de systemd-resolved o NetworkManager"
        fi
    fi

    # Sincronización horaria: si falla, las firmas de los paquetes se consideran inválidas
    if has timedatectl; then
        local ntp_sync
        ntp_sync=$(timedatectl show -p NTPSynchronized --value 2>/dev/null)
        if [ "$ntp_sync" = "yes" ]; then
            print_ok "Reloj sincronizado por NTP"
        else
            print_warn "Reloj no sincronizado: pacman puede rechazar firmas por fecha incorrecta"
            print_fix "sudo timedatectl set-ntp true"
        fi
    fi
}

# ------------------------------------
# 10. Seguridad básica
# ------------------------------------
check_security() {
    print_header "10. Seguridad"

    # Firewall
    if has ufw && ufw status 2>/dev/null | grep -q 'Status: active'; then
        print_ok "Firewall ufw activo"
    elif has firewall-cmd && firewall-cmd --state >/dev/null 2>&1; then
        print_ok "Firewall firewalld activo"
    elif has nft && [ -n "$(nft list ruleset 2>/dev/null)" ]; then
        print_ok "Reglas nftables presentes"
    elif has iptables && [ "$(iptables -S 2>/dev/null | wc -l)" -gt 3 ]; then
        print_ok "Reglas iptables presentes"
    else
        print_warn "No se detectó ningún firewall activo"
        print_fix "en un portátil de desarrollo suele bastar: sudo pacman -S ufw && sudo ufw enable"
    fi

    # SSH expuesto
    if has systemctl && systemctl is-active sshd >/dev/null 2>&1; then
        print_warn "sshd está activo: el equipo acepta conexiones SSH entrantes"
        if [ -r /etc/ssh/sshd_config ] && grep -Eq '^\s*PermitRootLogin\s+yes' /etc/ssh/sshd_config; then
            print_fail "sshd permite login de root con contraseña"
            print_fix "pon 'PermitRootLogin no' en /etc/ssh/sshd_config"
        fi
    else
        print_ok "sshd no está activo"
    fi

    # Usuarios con shell de login y sin contraseña
    if [ -r /etc/shadow ]; then
        local nopass
        nopass=$(awk -F: '($2 == "") {print $1}' /etc/shadow 2>/dev/null | tr '\n' ' ')
        [ -n "$nopass" ] && print_fail "Usuarios sin contraseña: $nopass"
    fi

    print_info "Usuarios con acceso sudo (grupo wheel): $(getent group wheel 2>/dev/null | cut -d: -f4)"

    # Permisos peligrosos en el PATH del usuario
    local dir
    for dir in ${PATH//:/ }; do
        if [ -d "$dir" ] && [ -w "$dir" ] && [[ "$dir" == /usr/* || "$dir" == /bin* || "$dir" == /sbin* ]]; then
            print_warn "El directorio del sistema $dir es escribible por tu usuario"
        fi
    done
}

# ------------------------------------
# 11. Entorno de desarrollo
# ------------------------------------
check_devtools() {
    print_header "11. Entorno de desarrollo"

    local tools=(git docker docker-compose java kotlinc gradle code lazygit yazi zsh starship rg fd bat btop node npm python psql)
    local missing=()
    local tool
    for tool in "${tools[@]}"; do
        if has "$tool"; then
            print_ok "$tool"
        else
            missing+=("$tool")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        print_info "No instalados: ${missing[*]}"
        print_fix "./scripts/install/arch/setup.sh instala la mayoría de estas herramientas"
    fi

    # Docker: pertenencia al grupo y estado del demonio
    if has docker; then
        if id -nG "$USER" 2>/dev/null | grep -qw docker; then
            print_ok "Tu usuario pertenece al grupo docker"
        else
            print_warn "Tu usuario no está en el grupo docker (necesitarás sudo para cada comando)"
            print_fix "sudo usermod -aG docker $USER   (requiere cerrar sesión)"
        fi
        if has systemctl && ! systemctl is-active docker >/dev/null 2>&1; then
            print_warn "El servicio docker no está activo"
            print_fix "sudo systemctl enable --now docker"
        fi
    fi

    # Shell por defecto
    local login_shell
    login_shell=$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)
    print_info "Shell de login: ${login_shell:-desconocido}"

    # ~/.local/bin en el PATH: relevante para instalaciones tipo tarball
    if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
        print_ok "$HOME/.local/bin está en el PATH"
    else
        print_warn "$HOME/.local/bin no está en el PATH (afecta a apps instaladas por tarball)"
        print_fix "añade 'export PATH=\"\$HOME/.local/bin:\$PATH\"' a tu ~/.zshrc o ~/.bashrc"
    fi

    # Lanzadores .desktop rotos: causa de iconos que no arrancan
    local desktop_file exec_path
    for desktop_file in "$HOME/.local/share/applications"/*.desktop; do
        [ -f "$desktop_file" ] || continue
        exec_path=$(awk -F'=' '/^Exec=/{print $2; exit}' "$desktop_file" | awk '{print $1}')
        if [ -n "$exec_path" ] && [ ! -x "${exec_path/#\~/$HOME}" ] && ! has "$exec_path"; then
            print_warn "Lanzador roto: $(basename "$desktop_file") apunta a $exec_path"
        fi
    done
}

# ------------------------------------
# Resumen
# ------------------------------------
print_summary() {
    print_header "Resumen"

    echo -e "${GREEN}Correctas:${NC} $COUNT_OK   ${YELLOW}Advertencias:${NC} $COUNT_WARN   ${RED}Problemas:${NC} $COUNT_FAIL"

    if [ ${#FAILURES[@]} -gt 0 ]; then
        echo ""
        echo -e "${RED}Requieren atención:${NC}"
        printf '  - %s\n' "${FAILURES[@]}"
    fi

    if [ ${#WARNINGS[@]} -gt 0 ]; then
        echo ""
        echo -e "${YELLOW}Conviene revisar:${NC}"
        printf '  - %s\n' "${WARNINGS[@]}"
    fi

    echo ""
    print_info "Este diagnóstico no modificó nada en tu sistema."
    if [ -n "$REPORT_FILE" ]; then
        print_info "Informe guardado en: $REPORT_FILE"
    fi
}

run_all() {
    echo -e "${CYAN}Arch Doctor${NC} - diagnóstico de solo lectura - $(date '+%Y-%m-%d %H:%M:%S')"
    check_system
    check_hardware
    check_storage
    check_pacman
    check_integrity
    check_systemd
    check_logs
    check_boot
    check_network
    check_security
    check_devtools
    print_summary
}

main() {
    parse_args "$@"

    if [ "$SAVE_REPORT" -eq 1 ]; then
        REPORT_FILE="$HOME/arch-doctor-$(date +%Y%m%d-%H%M%S).txt"
        # Se redirige la salida del propio shell (no una tubería) para que los
        # contadores del resumen sobrevivan y determinen el código de salida.
        exec > >(tee >(sed 's/\x1b\[[0-9;]*m//g' > "$REPORT_FILE"))
    fi

    run_all

    # 0 = todo correcto, 1 = solo advertencias, 2 = hay problemas que atender
    if [ "$COUNT_FAIL" -gt 0 ]; then
        exit 2
    elif [ "$COUNT_WARN" -gt 0 ]; then
        exit 1
    fi
    exit 0
}

main "$@"
