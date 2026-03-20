# AppMover 🗂

*Mueve apps de macOS al SSD — interfaz de terminal estilo Mole*

```
  ╔═══════════════════════════════════════════════╗
  ║   🗂  AppMover  —  Move apps to your SSD      ║
  ╚═══════════════════════════════════════════════╝

  ▶  ⇢  Mover apps al SSD
     ⇠  Restaurar apps al disco interno
     ●  Ver estado de discos y apps
     ⚙  Cambiar SSD de destino
     📋 Ver log de operaciones
     ✕  Salir

  ↑↓ Navegar  ·  Space Seleccionar  ·  Enter Confirmar  ·  Q Salir
```

## Instalación rápida

```bash
chmod +x appmover install.sh
bash install.sh
```

O copiarlo manualmente:

```bash
chmod +x appmover
sudo cp appmover /usr/local/bin/appmover
```

## Uso

```bash
appmover              # Menú interactivo completo
appmover --status     # Estado rápido de discos y apps
appmover --log        # Ver historial de operaciones
appmover --help       # Ayuda
```

## Navegación

| Tecla | Acción |
|-------|--------|
| `↑` / `k` | Subir |
| `↓` / `j` | Bajar |
| `Space` | Seleccionar/deseleccionar |
| `A` | Seleccionar todo |
| `N` | Deseleccionar todo |
| `Enter` | Confirmar |
| `Q` | Salir |

## Cómo funciona

1. **Mover al SSD**: Copia la app con `rsync` a `<SSD>/Applications/` y crea un symlink en `/Applications/` para que el sistema la siga viendo normalmente.

2. **Restaurar**: Copia de vuelta la app al disco interno, elimina el symlink y borra la copia del SSD.

3. **Symlinks**: Las apps movidas siguen apareciendo en Launchpad, Spotlight y `/Applications` sin ninguna configuración extra.

## Configuración

Se guarda en `~/.config/appmover/config`  
Log de operaciones en `~/.config/appmover/appmover.log`

## Requisitos

- macOS con `bash` 3.2+ (ya incluido)
- `rsync` (ya incluido en macOS)
- SSD montado en `/Volumes/`

## Notas

- **Permisos**: Algunas apps del sistema pueden requerir `sudo`. AppMover avisará si hay un error.
- **Seguridad**: La operación pide confirmación antes de ejecutar.
- **Recuperación**: Si algo sale mal, el log en `~/.config/appmover/appmover.log` guarda cada operación.
- **Terminal recomendado**: Alacritty, kitty, WezTerm, Ghostty o Warp. iTerm2 puede tener problemas con el renderizado de caracteres especiales.

## Licencia

MIT
