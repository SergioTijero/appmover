#!/usr/bin/env bash
# AppMover — install.sh
# Instala appmover en /usr/local/bin

set -euo pipefail

BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="appmover"

echo ""
echo -e "${BOLD}${CYAN}  AppMover — Instalador${RESET}"
echo -e "  ${BOLD}═══════════════════════${RESET}"
echo ""

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

echo -e "  ${GREEN}✓${RESET} Instalado en ${BOLD}${INSTALL_DIR}/${SCRIPT_NAME}${RESET}"
echo ""
echo -e "  ${BOLD}Uso:${RESET}"
echo "    appmover              # Menú interactivo"
echo "    appmover --status     # Estado rápido"
echo "    appmover --log        # Ver historial"
echo "    appmover --help       # Ayuda"
echo ""
echo -e "  ${CYAN}¡Listo! Ejecuta ${BOLD}appmover${RESET}${CYAN} para empezar.${RESET}"
echo ""
