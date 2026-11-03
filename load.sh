#!/system/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KO_PATH="$SCRIPT_DIR/4.14.264.ko"

if [ ! -f "$KO_PATH" ]; then
    echo "[✘] Error: .ko file not found in current directory ($SCRIPT_DIR)!"
    exit 1
fi

output=$(insmod "$KO_PATH" 2>&1)
status=$?

if [ $status -eq 0 ]; then
    echo "[✓] Kernel module successfully loaded!"
elif echo "$output" | grep -q "File exists"; then
    # \033[1;31m হলো টার্মিনালের জন্য লাল (Red) রঙের কোড এবং \033[0m দিয়ে কালার রিসেট করা হয়েছে
    echo "[!] Kernel module is ALREADY LOADED!"
else
    echo "[✘] Failed to load kernel module: $output"
fi
