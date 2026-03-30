#!/usr/bin/env bash
# AppMover — install.sh

set -euo pipefail

BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
RED="\033[31m"
DIM="\033[2m"
RESET="\033[0m"

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="appmover"

echo ""
echo -e "${BOLD}${CYAN}  AppMover — Instalador${RESET}"
echo -e "  ${BOLD}═══════════════════════${RESET}"
echo ""

# Verify Bash version (requires 4.3+ for namerefs)
if (( BASH_VERSINFO[0] < 4 || ( BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 3 ) )); then
  echo -e "  ${YELLOW}⚠  Bash ${BASH_VERSION} detectado.${RESET}"
  echo -e "  ${DIM}AppMover requiere Bash 4.3+. Instálalo con: brew install bash${RESET}"
  echo ""
fi

# Detect script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$SCRIPT_DIR/appmover"

if [[ ! -f "$SOURCE" ]]; then
  echo -e "  ${RED}✗ No se encontró el archivo 'appmover' en ${SCRIPT_DIR}${RESET}"
  exit 1
fi

# Make executable
chmod +x "$SOURCE"

# Install
if [[ -w "$INSTALL_DIR" ]]; then
  cp "$SOURCE" "$INSTALL_DIR/$SCRIPT_NAME"
else
  echo -e "  ${YELLOW}⚠  Se necesitan permisos de administrador para instalar en ${INSTALL_DIR}${RESET}"
  sudo cp "$SOURCE" "$INSTALL_DIR/$SCRIPT_NAME"
fi

VERSION=$(grep '^VERSION=' "$SOURCE" | head -1 | tr -d '"' | cut -d= -f2)
echo -e "  ${GREEN}✓${RESET} Instalado en ${BOLD}${INSTALL_DIR}/${SCRIPT_NAME}${RESET}  ${DIM}v${VERSION}${RESET}"
echo ""
echo -e "  ${BOLD}Comandos:${RESET}"
echo "    appmover              # Menú interactivo"
echo "    appmover --status     # Estado de discos y apps"
echo "    appmover --verify     # Verificar integridad de symlinks"
echo "    appmover --log        # Ver historial de operaciones"
echo "    appmover --help       # Ayuda"
echo ""
echo -e "  ${CYAN}¡Listo! Ejecuta ${BOLD}appmover${RESET}${CYAN} para empezar.${RESET}"
echo ""
