# 🩺 Arch Doctor

Diagnóstico completo y **no destructivo** de un sistema Arch Linux.

El script `scripts/diagnostics/arch-doctor.sh` solo **lee** información del sistema:
no instala, no elimina, no modifica configuración y no ejecuta `sudo`. Cada hallazgo
incluye el comando sugerido para que la corrección la decidas y la ejecutes tú.

## Uso

```bash
./scripts/diagnostics/arch-doctor.sh              # informe en pantalla
./scripts/diagnostics/arch-doctor.sh --report     # además guarda ~/arch-doctor-<fecha>.txt
./scripts/diagnostics/arch-doctor.sh --no-color   # sin colores, ideal para pegar en un issue
```

### Códigos de salida

| Código | Significado |
| ------ | ----------- |
| `0`    | Todo correcto |
| `1`    | Solo advertencias |
| `2`    | Hay problemas que requieren atención |

## Qué revisa

| Bloque | Comprobaciones |
| ------ | -------------- |
| 1. Sistema | Distribución, kernel, arquitectura, modo de arranque (UEFI/BIOS) y si el kernel en ejecución ya no tiene sus módulos en disco (obliga a reiniciar) |
| 2. Hardware | CPU, memoria, swap, GPU, temperatura y batería |
| 3. Almacenamiento | Uso por partición, `/boot` casi lleno, inodos agotados, errores de sistema de archivos o E/S en el journal |
| 4. Pacman | Lock huérfano, antigüedad de la base de datos, actualizaciones pendientes, huérfanos, paquetes AUR/foráneos, `.pacnew`/`.pacsave`, tamaño de caché, keyring, mirrors y repos de terceros |
| 5. Integridad | Archivos faltantes de paquetes (`pacman -Qk`) y paquetes que deberían recompilarse (`checkrebuild`) |
| 6. systemd | Estado global, unidades fallidas de sistema y de usuario, servicios habilitados inactivos, tiempo de arranque |
| 7. Registros | Errores del arranque actual, errores más frecuentes, volcados de memoria recientes, tamaño del journal |
| 8. Arranque | Initramfs más antiguo que el kernel, módulos DKMS sin compilar, firmware que no se pudo cargar |
| 9. Red | Interfaces activas, direcciones, DNS, conectividad y sincronización horaria (afecta a la verificación de firmas) |
| 10. Seguridad | Firewall activo, `sshd` expuesto, `PermitRootLogin`, usuarios sin contraseña, grupo `wheel`, directorios del sistema escribibles |
| 11. Entorno de desarrollo | Herramientas instaladas, grupo y servicio de Docker, shell de login, `~/.local/bin` en el `PATH`, lanzadores `.desktop` rotos |

## Riesgos específicos de Arch que cubre

- **Actualizaciones parciales:** avisa si la base de datos de repos está desactualizada
  y recuerda que `pacman -Sy` sin `-u` deja el sistema en un estado inconsistente.
- **`.pacnew` sin fusionar:** configuración que quedó atrás tras una actualización
  y que suele provocar fallos difíciles de rastrear.
- **Paquetes AUR:** no se actualizan con `pacman -Syu` y pueden quedar enlazados a
  bibliotecas que ya no existen.
- **Kernel actualizado sin reiniciar:** los módulos del kernel en ejecución desaparecen
  del disco y deja de poder cargarse hardware nuevo.
- **Keyring o reloj desincronizado:** ambos hacen que pacman rechace firmas válidas.

## Herramientas opcionales

Algunas comprobaciones necesitan paquetes extra; sin ellos el script simplemente lo indica:

```bash
sudo pacman -S pacman-contrib      # checkupdates, paccache, pacdiff
sudo pacman -S rebuild-detector    # checkrebuild
sudo pacman -S lm_sensors pciutils # temperaturas e información de GPU
```

## Diferencia con `scripts/doctor.sh`

`scripts/doctor.sh` solo comprueba si las herramientas de desarrollo están instaladas.
`arch-doctor.sh` diagnostica el sistema operativo completo y es específico de Arch.
