#!/bin/bash
set -euo pipefail

log_error() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: $1" >&2
}

trap 'log_error "Script interrupted or failed"; exit 1' ERR INT TERM

declare -A files_map=(
  ["test.service"]="/etc/systemd/system/test.service"
  ["test.sh"]="/usr/local/bin/test.sh"
  ["process_monitor.service"]="/etc/systemd/system/process_monitor.service"
  ["monitor.sh"]="/usr/local/bin/monitor.sh"
  ["process_monitor.timer"]="/etc/systemd/system/process_monitor.timer"
)


for src in "${!files_map[@]}"; do
  dest="${files_map[$src]}"
  if ! sudo cp "$src" "$dest"; then
    log_error "Failed to copy $src to $dest"
    exit 1
  fi
  echo "Копируем файл $src в $dest"

  if [[ "$dest" == /usr/local/bin/* ]]; then
    sudo chmod +x "$dest"
    echo "Делаем файл $dest исполняемым"
  fi
done


sudo systemctl daemon-reload
echo "Обновляем конфигурацию systemd"


for dest in "${files_map[@]}"; do
  basefile=$(basename "$dest")
  
  if [[ "$dest" == *.service ]] || [[ "$dest" == *.timer ]]; then
    sudo systemctl restart "$basefile"
    sudo systemctl enable "$basefile"
    echo "Перезапускаем и включаем $basefile"
  fi
done
