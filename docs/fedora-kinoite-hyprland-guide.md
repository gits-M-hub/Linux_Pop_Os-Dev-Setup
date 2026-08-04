# Guía Completa: Fedora Kinoite + Hyprland + Linux Dev Setup

## 📋 Índice

1. [Preparación](#preparación)
2. [Instalación de Fedora Kinoite](#instalación-de-fedora-kinoite)
3. [Configuración de Hyprland](#configuración-de-hyprland)
4. [Instalación del Proyecto Linux Dev Setup](#instalación-del-proyecto-linux-dev-setup)
5. [Configuración de Herramientas de Desarrollo](#configuración-de-herramientas-de-desarrollo)
6. [Solución de Problemas](#solución-de-problemas)

---

## 🚀 Preparación

### Requisitos del Sistema

- **Procesador:** x86_64 (Intel/AMD)
- **RAM:** Mínimo 8GB (recomendado 16GB+ para desarrollo)
- **Almacenamiento:** Mínimo 50GB (recomendado 100GB+)
- **Conexión a internet:** Estable durante la instalación

### Descargar Fedora Kinoite

1. **Ir al sitio oficial:** https://fedoraproject.org/spins/kinoite/
2. **Descargar la ISO:** Fedora Kinoite 40 (o versión más reciente)
3. **Verificar checksum:**
   ```bash
   sha256sum Fedora-Kinoite-*.iso
   ```
4. **Crear USB booteable:**
   - Windows: Usar **Rufus** o **Ventoy**
   - Linux: Usar `dd` o **BalenaEtcher**
   ```bash
   # Ejemplo con dd en Linux
   sudo dd if=Fedora-Kinoite-*.iso of=/dev/sdX bs=4M status=progress sync
   ```

### Preparación de Particiones (Reutilizando partición de Arch)

Si vienes de Arch Linux y quieres reutilizar su partición:

**⚠️ ADVERTENCIA IMPORTANTE:**

En muchos sistemas, Arch Linux y Windows tienen entradas con el **mismo nombre** ("Windows Boot Manager") en el bootloader, lo que hace muy peligroso eliminar la entrada equivocada. **NO uses bcdedit directamente** a menos que estés 100% seguro.

**MÉTODO SEGURO RECOMENDADO:**

**Opción 1: Usar EasyBCG (Windows - GUI - Recomendado)**

1. **Descargar EasyBCG:** https://neosmart.net/EasyBCD/
2. **Ejecutar como Administrador**
3. **En la pestaña "Edit Boot Entries":**
   - Identifica la entrada de Arch Linux (usualmente dice "Arch Linux" o tiene un icono de Linux)
   - Selecciona la entrada de Arch
   - Click en "Delete"
4. **En la pestaña "BCD Deployment":**
   - Asegúrate que "Install the Windows Vista/7 bootloader to the MBR" esté seleccionado
   - Click en "Write MBR"

**Opción 2: Usar bcdedit con identificación por PATH (Solo si estás seguro)**

Si prefieres usar línea de comandos, identifica la entrada de Arch por su PATH:

```powershell
# Ver todas las entradas con sus paths
bcdedit /enum all | findstr /i "path"
```

La entrada de Arch tendrá un path como: `\EFI\Linux\arch-linux.efi`
La entrada de Windows tendrá: `\EFI\Microsoft\Boot\bootmgfw.efi`

```powershell
# ELIMINA SOLO la entrada que tenga path \EFI\Linux\arch-linux.efi
# Reemplaza {ID} con el identificador que tenga ese path específico
bcdedit /delete {bootmgr} /f
```

**⚠️ Si eliminas la entrada equivocada, podrías perder el acceso a Windows.**

**Opción 3: Dejar el bootloader de Arch intacto (Más seguro)**

La opción más segura es **no tocar el bootloader de Arch**. Durante la instalación de Fedora:

1. Fedora detectará el bootloader existente
2. Fedora añadirá su propia entrada al bootloader
3. Podrás elegir entre Arch y Fedora en el arranque
4. Después de confirmar que Fedora funciona, puedes formatear la partición de Arch desde el instalador de Fedora

**Limpiar la partición de Arch (después de remover el bootloader):**

```powershell
diskpart
list disk
select disk X  # Reemplaza X con el número de disco donde está Arch
list partition
select partition Y  # Reemplaza Y con el número de partición de Arch
override
remove partition override
exit
```

**IMPORTANTE:** Esto solo limpia el sector de arranque, NO borra los datos de la partición. Fedora detectará esta partición como "espacio libre" durante la instalación.

---

## 💿 Instalación de Fedora Kinoite

### Arranque desde USB

1. **Insertar el USB de Fedora Kinoite**
2. **Reiniciar y entrar al BIOS/UEFI** (F2, F12, o Delete según tu motherboard)
3. **Configurar el orden de arranque:** USB primero
4. **Guardar y reiniciar**

### Proceso de Instalación

1. **Seleccionar "Install Fedora Kinoite"**
2. **Idioma:** Seleccionar tu idioma preferido
3. **Configuración de instalación:**

   **a) Instalación de destino (Particionamiento):**
   
   - **Opción recomendada:** "Custom" (Personalizado)
   - **Estructura de particiones sugerida:**
   
   | Partición | Tamaño | Tipo | Punto de montaje |
   |-----------|--------|------|------------------|
   | EFI System Partition | 512MB | EFI System Partition | /boot/efi |
   | /boot | 1GB | ext4 | /boot |
   | / | 50GB+ | btrfs | / |
   | /home | Resto | btrfs | /home |
   | swap | 8GB+ | swap | - |
   
   **Si reutilizas la partición de Arch:**
   - Selecciona la partición de Arch como "/"
   - Formatea como btrfs
   - Crea nuevas particiones para /boot/efi y /home si es necesario

   **b) Red y nombre de host:**
   - Configurar conexión WiFi si es necesario
   - Nombre del host: `fedora-dev` (o tu preferencia)

   **c) Usuario:**
   - Nombre completo: Tu nombre
   - Nombre de usuario: Tu username (sin espacios, minúsculas)
   - Contraseña: Fuerte y memorable
   - Marcar "Hacer administrador"

4. **Iniciar instalación**
5. **Reiniciar cuando termine**

### Post-Instalación Inmediata

1. **Actualizar el sistema:**
   ```bash
   sudo rpm-ostree upgrade
   ```

2. **Instalar Flatpak (si no está):**
   ```bash
   sudo rpm-ostree install flatpak
   sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```

3. **Reiniciar para aplicar cambios:**
   ```bash
   sudo reboot
   ```

---

## 🖥️ Configuración de Hyprland

### ¿Por qué Hyprland?

- **Tiling window manager** dinámico y moderno
- **Basado en Wayland** (más seguro y moderno que X11)
- **Personalización extrema** vía configuración
- **Rendimiento excelente** en hardware moderno
- **Integración perfecta** con Fedora Kinoite (inmutable)

### Instalación de Hyprland en Fedora Kinoite

**Fedora Kinoite usa rpm-ostree, por lo que la instalación es diferente:**

1. **Instalar Hyprland y dependencias:**
   ```bash
   sudo rpm-ostree install hyprland waybar rofi wofi dunst swww grim slurp swappy \
     pavucontrol pipewire-pulseaudio wireplumber bluez bluez-tools \
     network-manager-applet nm-connection-editor polkit-gnome
   ```

2. **Instalar herramientas adicionales:**
   ```bash
   sudo rpm-ostree install kitty neovim zsh starship bat exa fd-find ripgrep \
     lazygit yazi btop htop unzip curl wget git gcc make
   ```

3. **Instalar fuentes y temas:**
   ```bash
   sudo rpm-ostree install google-noto-fonts-common google-noto-sans-cjk-fonts \
     google-noto-serif-cjk-fonts fontawesome-fonts fira-code-fonts \
     jetbrains-mono-fonts
   ```

4. **Reiniciar para aplicar cambios:**
   ```bash
   sudo reboot
   ```

### Configuración de Hyprland

1. **Crear directorio de configuración:**
   ```bash
   mkdir -p ~/.config/hypr
   ```

2. **Configuración básica de Hyprland (`~/.config/hypr/hyprland.conf`):**
   
   ```conf
   # ============================
   # Hyprland Configuration
   # ============================
   
   # Monitor
   monitor=eDP-1,1920x1080,0x0,1
   
   # Input
   input {
       kb_layout=us
       kb_variant=
       kb_model=
       kb_options=
       kb_rules=
       
       follow_mouse=1
       sensitivity=0
       touchpad {
           natural_scroll=0
       }
   }
   
   # General
   general {
       gaps_in=5
       gaps_out=20
       border_size=2
       col.active_border=rgba(33ccffee)
       col.inactive_border=rgba(595959aa)
       layout=dwindle
   }
   
   # Decoration
   decoration {
       rounding=10
       blur {
           enabled=yes
           size=3
           passes=3
       }
       drop_shadow=yes
       shadow_range=4
       shadow_render_power=3
       col.shadow=rgba(1a1a1aee)
   }
   
   # Animations
   animations {
       enabled=yes
       bezier=wind,0.05,0.9,0.1,1.05
       animation=windows,1,7,wind
       animation=border,1,10,default
       animation=fade,1,10,default
   }
   
   # Window rules
   windowrule=float,^(pavucontrol)$
   windowrule=float,^(nm-connection-editor)$
   windowrule=float,^(blueman-manager)$
   
   # Keybinds
   $mod=SUPER
   
   # Terminal
   bind=$mod,Return,exec,kitty
   
   # Application launcher
   bind=$mod,D,exec,wofi --show drun
   
   # Kill window
   bind=$mod,SHIFT,Q,killactive,
   
   # Move focus
   bind=$mod,LEFT,movefocus,l
   bind=$mod,RIGHT,movefocus,r
   bind=$mod,UP,movefocus,u
   bind=$mod,DOWN,movefocus,d
   
   # Move window
   bind=$mod SHIFT,LEFT,movewindow,l
   bind=$mod SHIFT,RIGHT,movewindow,r
   bind=$mod SHIFT,UP,movewindow,u
   bind=$mod SHIFT,DOWN,movewindow,d
   
   # Resize window
   bind=$mod CONTROL,LEFT,resizeactive,-20 0
   bind=$mod CONTROL,RIGHT,resizeactive,20 0
   bind=$mod CONTROL,UP,resizeactive,0 -20
   bind=$mod CONTROL,DOWN,resizeactive,0 20
   
   # Toggle fullscreen
   bind=$mod,F,fullscreen,
   
   # Toggle floating
   bind=$mod,SPACE,togglefloating,
   
   # Workspace
   bind=$mod,1,workspace,1
   bind=$mod,2,workspace,2
   bind=$mod,3,workspace,3
   bind=$mod,4,workspace,4
   bind=$mod,5,workspace,5
   bind=$mod,6,workspace,6
   bind=$mod,7,workspace,7
   bind=$mod,8,workspace,8
   bind=$mod,9,workspace,9
   bind=$mod,0,workspace,10
   
   # Move to workspace
   bind=$mod SHIFT,1,movetoworkspace,1
   bind=$mod SHIFT,2,movetoworkspace,2
   bind=$mod SHIFT,3,movetoworkspace,3
   bind=$mod SHIFT,4,movetoworkspace,4
   bind=$mod SHIFT,5,movetoworkspace,5
   bind=$mod SHIFT,6,movetoworkspace,6
   bind=$mod SHIFT,7,movetoworkspace,7
   bind=$mod SHIFT,8,movetoworkspace,8
   bind=$mod SHIFT,9,movetoworkspace,9
   bind=$mod SHIFT,0,movetoworkspace,10
   
   # Media keys
   bind=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
   bind=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
   bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle
   bind=,XF86MonBrightnessUp,exec,brightnessctl set 5%+
   bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-
   
   # Screenshot
   bind=$mod,PRINT,exec,grim ~/Pictures/screenshot_$(date +%s).png
   bind=$mod SHIFT,PRINT,exec,grim -g "$(slurp)" ~/Pictures/screenshot_$(date +%s).png
   
   # Reload config
   bind=$mod SHIFT,R,exec,hyprctl reload
   ```

3. **Configuración de Waybar (`~/.config/waybar/config`):**
   
   ```json
   {
       "layer": "top",
       "position": "top",
       "height": 30,
       "spacing": 0,
       "modules-left": ["hyprland/workspaces", "hyprland/window"],
       "modules-center": ["clock"],
       "modules-right": ["tray", "pulseaudio", "network", "cpu", "memory", "battery"],
       
       "hyprland/modules-left": ["hyprland/workspaces"],
       "hyprland/workspaces": {
           "format": "{name}",
           "persistent-workspaces": {
              "1": [],
              "2": [],
              "3": [],
              "4": [],
              "5": []
           }
       },
       
       "clock": {
           "format": "{:%H:%M}",
           "format-alt": "{:%A, %B %d, %Y}",
           "tooltip-format": "<tt><small>{calendar}</small></tt>",
           "calendar": {
               "mode": "year",
               "mode-mon-col": 3,
               "weeks-pos": "right",
               "format": {
                   "months": "<span color='#ffead3'><b>{}</b></span>",
                   "days": "<span color='#ecc6d9'><b>{}</b></span>",
                   "weeks": "<span color='#99ffdd'><b>W{}</b></span>",
                   "weekdays": "<span color='#ffcc66'><b>{}</b></span>",
                   "today": "<span color='#ff6699'><b><u>{}</u></b></span>"
               }
           },
           "actions": {
               "on-click-right": "mode",
               "on-scroll-up": "shift_up",
               "on-scroll-down": "shift_down"
           }
       },
       
       "cpu": {
           "format": "CPU {}%",
           "interval": 2,
           "tooltip": true
       },
       
       "memory": {
           "format": "MEM {}%",
           "interval": 2,
           "tooltip": true
       },
       
       "battery": {
           "states": {
               "warning": 30,
               "critical": 15
           },
           "format": "{icon}  {}%",
           "format-charging": "⚡ {}%",
           "format-plugged": " {}%",
           "format-icons": ["", "", "", "", ""],
           "tooltip-format": "{time} remaining"
       },
       
       "network": {
           "format-wifi": "{icon}",
           "format-ethernet": "",
           "format-linked": "{icon} (No IP)",
           "format-disconnected": "⚠ Disconnected",
           "format-icons": ["", "", "", "", ""],
           "tooltip-format": "{ifname}: {ipaddr}"
       },
       
       "pulseaudio": {
           "format": "{icon} {volume}%",
           "format-muted": "",
           "format-icons": {
               "default": ["", "", ""]
           },
           "on-click": "pavucontrol"
       },
       
       "tray": {
           "icon-size": 16,
           "spacing": 0
       }
   }
   ```

4. **Estilo de Waybar (`~/.config/waybar/style.css`):**
   
   ```css
   * {
       font-family: "JetBrains Mono", "Symbols Nerd Font";
       font-size: 13px;
       min-height: 0;
       margin: 0;
       padding: 0;
   }
   
   window#waybar {
       background: rgba(30, 30, 46, 0.9);
       border-bottom: 2px solid rgba(137, 221, 255, 0.5);
       color: #cdd6f4;
   }
   
   #workspaces {
       margin: 0 10px;
   }
   
   #workspaces button {
       padding: 0 10px;
       color: #6c7086;
   }
   
   #workspaces button.active {
       color: #89b4fa;
       border-bottom: 2px solid #89b4fa;
   }
   
   #clock {
       padding: 0 15px;
       color: #f9e2af;
   }
   
   #cpu {
       padding: 0 10px;
       color: #a6e3a1;
   }
   
   #memory {
       padding: 0 10px;
       color: #f38ba8;
   }
   
   #battery {
       padding: 0 10px;
       color: #f9e2af;
   }
   
   #network {
       padding: 0 10px;
       color: #89b4fa;
   }
   
   #pulseaudio {
       padding: 0 10px;
       color: #cba6f7;
   }
   
   #tray {
       padding: 0 10px;
   }
   ```

5. **Configuración de Wofi (launcher):**
   
   ```bash
   mkdir -p ~/.config/wofi
   ```
   
   `~/.config/wofi/style.css`:
   ```css
   window {
       background: rgba(30, 30, 46, 0.95);
       border: 2px solid rgba(137, 221, 255, 0.5);
       border-radius: 10px;
   }
   
   #input {
       background: rgba(49, 50, 68, 0.8);
       border: none;
       border-radius: 5px;
       color: #cdd6f4;
       padding: 10px;
       margin: 10px;
   }
   
   #inner-box {
       margin: 10px;
   }
   
   #text {
       color: #cdd6f4;
   }
   
   #text:selected {
       color: #89b4fa;
   }
   
   #entry {
       padding: 8px;
       border-radius: 5px;
   }
   
   #entry:selected {
       background: rgba(137, 221, 255, 0.3);
   }
   ```

6. **Configuración de Kitty (terminal):**
   
   ```bash
   mkdir -p ~/.config/kitty
   ```
   
   `~/.config/kitty/kitty.conf`:
   ```conf
   font_family JetBrains Mono
   font_size 12
   bold_font auto
   italic_font auto
   bold_italic_font auto
   
   background_opacity 0.9
   background_blur 10
   
   foreground #cdd6f4
   background #1e1e2e
   cursor #f5e0dc
   
   color0 #1e1e2e
   color1 #f38ba8
   color2 #a6e3a1
   color3 #f9e2af
   color4 #89b4fa
   color5 #cba6f7
   color6 #94e2d5
   color7 #a6adc8
   color8 #6c7086
   color9 #f38ba8
   color10 #a6e3a1
   color11 #f9e2af
   color12 #89b4fa
   color13 #cba6f7
   color14 #94e2d5
   color15 #cdd6f4
   
   tab_bar_style fade
   active_tab_foreground #1e1e2e
   active_tab_background #89b4fa
   inactive_tab_foreground #6c7086
   inactive_tab_background #1e1e2e
   
   enable_audio_bell no
   window_padding_width 10
   ```

7. **Configurar Hyprland como sesión por defecto:**
   
   ```bash
   # Crear archivo de sesión
   sudo nano /usr/share/wayland-sessions/hyprland.desktop
   ```
   
   Contenido:
   ```ini
   [Desktop Entry]
   Name=Hyprland
   Comment=Hyprland Tiling Window Manager
   Exec=Hyprland
   Type=Application
   ```

8. **Reiniciar y seleccionar Hyprland en el login manager**

---

## 🔧 Instalación del Proyecto Linux Dev Setup

### Clonar el Repositorio

1. **Instalar git si no está:**
   ```bash
   sudo rpm-ostree install git
   sudo reboot
   ```

2. **Clonar el repositorio:**
   ```bash
   cd ~
   git clone https://github.com/gits-M-hub/Linux-Dev_Multi_Setups.git
   cd Linux-Dev_Multi_Setups
   ```

### Preparación para Fedora Kinoite (Especial)

**Fedora Kinoite es inmutable, por lo que necesitamos ajustes especiales:**

1. **Crear directorio de proyectos:**
   ```bash
   mkdir -p ~/Projects
   mv ~/Linux-Dev_Multi_Setups ~/Projects/
   cd ~/Projects/Linux-Dev_Multi_Setups
   ```

2. **Instalar herramientas base vía rpm-ostree:**
   ```bash
   sudo rpm-ostree install zsh starship tree bat exa fd-find ripgrep btop htop \
     unzip curl wget gcc make python3 python3-pip nodejs npm
   sudo reboot
   ```

3. **Instalar herramientas vía Flatpak (cuando rpm-ostree no es suficiente):**
   ```bash
   flatpak install flathub com.visualstudio.code
   flatpak install flathub io.github.zen_browser.zen
   ```

4. **Instalar LazyGit (descarga directa):**
   ```bash
   cd /tmp
   LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
   curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
   tar xf lazygit.tar.gz
   sudo install lazygit /usr/local/bin
   rm lazygit.tar.gz lazygit
   ```

5. **Instalar Yazi (via cargo):**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source ~/.cargo/env
   cargo install --locked yazi
   ```

### Configuración de Zsh y Oh My Zsh

1. **Cambiar shell a zsh:**
   ```bash
   chsh -s /bin/zsh
   ```

2. **Instalar Oh My Zsh:**
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **Instalar Starship:**
   ```bash
   curl -fsSL https://starship.rs/install.sh | sh
   ```

4. **Configurar Starship en .zshrc:**
   ```bash
   echo 'eval "$(starship init zsh)"' >> ~/.zshrc
   ```

5. **Configuración de Starship (`~/.config/starship.toml`):**
   ```toml
   [directory]
   truncation_length = 3
   truncate_to_repo = false
   
   [git_branch]
   symbol = ""
   
   [git_status]
   conflicted = ""
   ahead = ""
   behind = ""
   diverged = ""
   untracked = ""
   modified = ""
   staged = ""
   
   [nodejs]
   symbol = ""
   
   [python]
   symbol = ""
   
   [rust]
   symbol = ""
   
   [golang]
   symbol = ""
   ```

### Instalación de SDKMAN! y Java

1. **Instalar SDKMAN!:**
   ```bash
   curl -s "https://get.sdkman.io" | bash
   source "$HOME/.sdkman/bin/sdkman-init.sh"
   ```

2. **Instalar Java 21 LTS:**
   ```bash
   sdk install java 21.0.1-tem
   ```

3. **Instalar Kotlin:**
   ```bash
   sdk install kotlin
   ```

4. **Instalar Gradle:**
   ```bash
   sdk install gradle
   ```

### Instalación de Docker en Fedora Kinoite

**Docker en Kinoite requiere configuración especial:**

1. **Instalar Docker:**
   ```bash
   sudo rpm-ostree install docker docker-compose
   sudo reboot
   ```

2. **Habilitar e iniciar Docker:**
   ```bash
   sudo systemctl enable docker
   sudo systemctl start docker
   ```

3. **Añadir usuario al grupo docker:**
   ```bash
   sudo usermod -aG docker $USER
   ```

4. **Verificar instalación:**
   ```bash
   docker run hello-world
   ```

### Instalación de PostgreSQL

1. **Instalar PostgreSQL:**
   ```bash
   sudo rpm-ostree install postgresql postgresql-server
   sudo reboot
   ```

2. **Inicializar base de datos:**
   ```bash
   sudo /usr/bin/postgresql-setup --initdb
   ```

3. **Habilitar e iniciar PostgreSQL:**
   ```bash
   sudo systemctl enable postgresql
   sudo systemctl start postgresql
   ```

### Configuración de Git

1. **Configurar nombre y email:**
   ```bash
   git config --global user.name "Tu Nombre"
   git config --global user.email "tu@email.com"
   ```

2. **Configurar defaults:**
   ```bash
   git config --global init.defaultBranch main
   git config --global core.autocrlf input
   ```

### Instalación de Alias (Versión Fedora)

1. **Ejecutar script de instalación de alias:**
   ```bash
   cd ~/Projects/Linux-Dev_Multi_Setups
   ./scripts/install/install-aliases.sh --fedora
   ```

2. **Recargar configuración:**
   ```bash
   source ~/.zshrc
   ```

---

## 🛠️ Configuración de Herramientas de Desarrollo

### VS Code (Flatpak)

1. **Instalar extensiones esenciales:**
   - ESLint
   - Prettier
   - GitLens
   - Docker
   - Python
   - Java Extension Pack
   - Kotlin
   - Remote - SSH

2. **Configurar VS Code para usar herramientas del sistema:**
   ```json
   {
       "terminal.integrated.defaultProfile.linux": "zsh",
       "terminal.integrated.fontFamily": "JetBrains Mono",
       "editor.fontFamily": "JetBrains Mono",
       "editor.fontSize": 14,
       "editor.formatOnSave": true,
       "editor.defaultFormatter": "esbenp.prettier-vscode"
   }
   ```

### Configuración de PostgreSQL para Desarrollo

1. **Crear usuario de desarrollo:**
   ```bash
   sudo -u postgres createuser --interactive
   # Nombre: tu_usuario
   # Superusuario: yes
   # Crear base de datos: yes
   ```

2. **Crear base de datos de desarrollo:**
   ```bash
   sudo -u postgres createdb dev_db
   ```

3. **Configurar acceso sin contraseña (local):**
   ```bash
   sudo nano /var/lib/pgsql/data/pg_hba.conf
   ```
   
   Agregar/modificar:
   ```conf
   local   all             all                                     trust
   host    all             all             127.0.0.1/32            trust
   ```
   
   Reiniciar PostgreSQL:
   ```bash
   sudo systemctl restart postgresql
   ```

### Configuración de Docker para Desarrollo

1. **Crear docker-compose.yml para proyectos:**
   ```yaml
   version: '3.8'
   services:
     app:
       build: .
       ports:
         - "3000:3000"
       volumes:
         - .:/app
       environment:
         - NODE_ENV=development
   ```

2. **Configurar Docker daemon:**
   ```bash
   sudo nano /etc/docker/daemon.json
   ```
   
   ```json
   {
     "log-driver": "json-file",
     "log-opts": {
       "max-size": "10m",
       "max-file": "3"
     }
   }
   ```
   
   Reiniciar Docker:
   ```bash
   sudo systemctl restart docker
   ```

---

## 🔍 Solución de Problemas

### Hyprland no inicia

1. **Verificar que Wayland esté habilitado:**
   ```bash
   loginctl show-session $(loginctl | grep $(whoami) | awk '{print $1}') -p Type
   ```

2. **Revisar logs de Hyprland:**
   ```bash
   journalctl -xe | grep hyprland
   ```

3. **Verificar configuración:**
   ```bash
   hyprctl reload
   ```

### rpm-ostree no instala paquetes

1. **Actualizar el sistema:**
   ```bash
   sudo rpm-ostree upgrade
   sudo reboot
   ```

2. **Verificar espacio en disco:**
   ```bash
   df -h
   ```

3. **Limpiar versiones antiguas:**
   ```bash
   sudo rpm-ostree cleanup --rollback --base
   ```

### Flatpak no funciona

1. **Actualizar Flatpak:**
   ```bash
   sudo flatpak update
   ```

2. **Reinstalar Flatpak:**
   ```bash
   sudo rpm-ostree install flatpak
   sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   sudo reboot
   ```

### Docker no funciona sin sudo

1. **Verificar grupo docker:**
   ```bash
   groups $USER
   ```

2. **Añadir usuario al grupo:**
   ```bash
   sudo usermod -aG docker $USER
   ```

3. **Cerrar sesión y volver a entrar**

### PostgreSQL no inicia

1. **Verificar logs:**
   ```bash
   sudo journalctl -xe | grep postgresql
   ```

2. **Verificar configuración:**
   ```bash
   sudo postgresql-check-setup-dir
   ```

3. **Reinicializar si es necesario:**
   ```bash
   sudo rm -rf /var/lib/pgsql/data
   sudo /usr/bin/postgresql-setup --initdb
   sudo systemctl start postgresql
   ```

### Alias no funcionan

1. **Verificar que se carguen:**
   ```bash
   cat ~/.zshrc | grep linux-dev-setup
   ```

2. **Recargar configuración:**
   ```bash
   source ~/.zshrc
   ```

3. **Verificar archivos de alias:**
   ```bash
   ls -la ~/Projects/Linux-Dev_Multi_Setups/configs/aliases/
   ```

---

## 📚 Recursos Adicionales

### Documentación Oficial

- **Fedora Kinoite:** https://docs.fedoraproject.org/en-US/fedora-kinoite/
- **Hyprland:** https://wiki.hyprland.org/
- **rpm-ostree:** https://coreos.github.io/rpm-ostree/
- **Flatpak:** https://flatpak.org/

### Comunidades

- **Fedora Discussion:** https://discussion.fedoraproject.org/
- **Hyprland Discord:** https://discord.gg/hyprland
- **r/Fedora:** https://reddit.com/r/Fedora
- **r/Hyprland:** https://reddit.com/r/Hyprland

### Configuraciones de Referencia

- **Hyprland configs:** https://github.com/hyprland-community/hyprland-configs
- **Waybar themes:** https://github.com/Alexays/Waybar/wiki/Configuration
- **Kitty themes:** https://github.com/dexpota/kitty-themes

---

## ✅ Checklist Final

- [ ] Fedora Kinoite instalado y actualizado
- [ ] Hyprland configurado y funcionando
- [ ] Waybar configurado con módulos personalizados
- [ ] Kitty terminal configurado
- [ ] Wofi launcher funcionando
- [ ] Git configurado con nombre y email
- [ ] Zsh + Oh My Zsh + Starship instalados
- [ ] SDKMAN! + Java + Kotlin + Gradle instalados
- [ ] Docker funcionando sin sudo
- [ ] PostgreSQL funcionando y configurado
- [ ] VS Code instalado (Flatpak)
- [ ] Alias del proyecto instalados (versión Fedora)
- [ ] LazyGit y Yazi funcionando
- [ ] Todas las herramientas base instaladas

---

## 🎯 Siguientes Pasos

1. **Personalizar Hyprland:** Ajustar keybinds y layouts según tus preferencias
2. **Instalar aplicaciones adicionales:** Navegador, Spotify, Discord, etc.
3. **Configurar backups:** Usar Timeshift o borgbackup
4. **Optimizar rendimiento:** Ajustar configuraciones de energía y GPU
5. **Explorar ecosistema Flatpak:** Instalar más aplicaciones desde Flathub

---

**¡Felicidades!** Ahora tienes un sistema Fedora Kinoite + Hyprland completamente configurado para desarrollo con el proyecto Linux Dev Setup.
