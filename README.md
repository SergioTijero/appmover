# AppMover

**Reclaim space on your Mac's internal disk by moving apps to an external SSD — transparently.**

AppMover moves `.app` bundles from `/Applications` to an external SSD and replaces them with symlinks, so Spotlight, Launchpad, and every launcher keep working as if nothing changed. All through a keyboard-driven terminal UI.

```
  ╔═══════════════════════════════════════════════╗
  ║   🗂  AppMover  —  Move apps to your SSD      ║
  ╚═══════════════════════════════════════════════╝
  SSD: /Volumes/MySSD  ·  v1.2.0  ·  j/k para navegar

  ▶  ⇢  Mover apps al SSD
     ⇠  Restaurar apps al disco interno
     ●  Ver estado de discos y apps
     ✔  Verificar integridad de symlinks
     🧹 Limpiar symlinks huérfanos
     ⚙  Cambiar SSD de destino
     📋 Ver log de operaciones
     ✕  Salir

  ↑↓ / j k Navegar  ·  Space Seleccionar  ·  Enter Confirmar  ·  Q Salir
```

---

## Why AppMover?

macOS applications can be surprisingly large — Xcode alone is 15 GB. When your Mac's internal SSD fills up, you lose performance and headroom for updates. AppMover solves this with a simple idea: **store the app on an external SSD, keep a symlink where macOS expects it**. The system never knows the difference.

- **No wrappers, no daemons, no background processes** — just symlinks
- **Reversible at any time** — restore an app to the internal disk in seconds
- **Safe** — asks for confirmation before every operation, logs everything

---

## Features

- **Move apps to SSD** — multi-select, size preview, pre-move space validation
- **Restore apps** — bring any app back to the internal disk with one command
- **Space check** — warns before moving if the SSD doesn't have enough free space
- **Symlink verification** — detects broken symlinks after a move or if the SSD was reformatted
- **Orphaned symlink cleanup** — removes dead symlinks left behind by uninstalled or moved apps
- **Disk status** — visual bar showing used/free space on both internal disk and SSD
- **Operation log** — every move and restore is recorded with timestamp
- **Keyboard-driven TUI** — arrow keys and vim bindings (`j`/`k`), multi-select with `Space`

---

## Requirements

| Requirement | Details |
|---|---|
| macOS | 11 Big Sur or later |
| Bash | 3.2+ (the version included with macOS — no extra install needed) |
| rsync | Included in macOS |
| External volume | SSD mounted under `/Volumes/` |

---

## Installation

**One-liner:**

```bash
bash install.sh
```

**Manual:**

```bash
chmod +x appmover
sudo cp appmover /usr/local/bin/appmover
```

**Verify the install:**

```bash
appmover --version
```

---

## Usage

```
appmover              Interactive TUI menu
appmover --status     Quick disk and app summary
appmover --verify     Check all app symlinks for integrity
appmover --log        Print full operation history
appmover --reset      Forget the configured SSD (pick a new one on next run)
appmover --version    Print version
appmover --help       Show usage
```

---

## How It Works

When you move an app, AppMover does three things:

```
/Applications/Slack.app          →   /Volumes/MySSD/Applications/Slack.app
(real bundle, ~300 MB)               (real bundle, copied with rsync)

/Applications/Slack.app          ←── symlink
(now a symlink, ~0 bytes)
```

1. **rsync** copies the app bundle to `<SSD>/Applications/` (preserving permissions and metadata)
2. The original directory is removed
3. A symlink is created at the original path pointing to the SSD location

macOS follows the symlink transparently — Spotlight indexes it, Launchpad shows it, and opening it works exactly as before.

**Restoring** reverses the process: rsync back to `/Applications/`, symlink removed, SSD copy deleted.

---

## Navigation

| Key | Action |
|---|---|
| `↑` / `k` | Move up |
| `↓` / `j` | Move down |
| `Space` | Toggle selection |
| `A` | Select all |
| `N` | Deselect all |
| `Enter` | Confirm |
| `Q` | Quit |

---

## Config & Logs

| Path | Contents |
|---|---|
| `~/.config/appmover/config` | Saved SSD path |
| `~/.config/appmover/appmover.log` | Timestamped operation history |

To reset the saved SSD config:

```bash
appmover --reset
```

---

## Troubleshooting

**App shows as broken in Launchpad after disconnecting the SSD**
The symlink still exists but the SSD isn't mounted. Reconnect the SSD, or run `appmover` and use "Limpiar symlinks huérfanos" to remove stale entries. The app icon will disappear from Launchpad until the SSD is reconnected or the app is restored.

**"Permission denied" when moving system apps**
Some apps in `/Applications` are write-protected by macOS. Try running with `sudo appmover`, or skip those apps and move them manually.

**Terminal rendering issues (iTerm2)**
iTerm2 may misrender some Unicode block characters. Alacritty, kitty, WezTerm, Ghostty, and Warp all render correctly.

---

## Contributing

Issues and pull requests are welcome. Please open an issue first for significant changes so we can discuss the approach.

---

## License

MIT
