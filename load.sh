#!/system/bin/sh

# ১. স্ক্রিপ্টটি বর্তমানে যে ফোল্ডারে আছে, সেই ডিরেক্টরি স্বয়ংক্রিয়ভাবে বের করা
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ২. একই ফোল্ডারে থাকা .ko ফাইলের পাথ অটো-ডিটেক্ট করা
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
    echo "[!] Kernel module is ALREADY LOADED!"
else
    echo "[✘] Failed to load kernel module: $output"
fi
