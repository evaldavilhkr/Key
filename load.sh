#!/system/bin/sh

output=$(insmod /storage/emulated/0/MT2/Load/4.14.264.ko 2>&1)
status=$?

if [ $status -eq 0 ]; then
    echo "Kernel module successfully loaded!"
elif echo "$output" | grep -q "File exists"; then
    echo "Kernel module is already loaded!"
else
    echo "Failed to load kernel module: $output"
fi
