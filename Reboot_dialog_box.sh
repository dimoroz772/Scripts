#!/usr/bin/env bash

output="$(needs-restarting -r 2>&1)"
rc=$?

if printf '%s\n' "$output" | grep -q "Требуется перезагрузка"; then
    zenity --question \
        --title="Требуется перезагрузка" \
        --text="На вашем компьютере установлены обновления. Чтобы изменения применились, нужно перезагрузить компьютер. Без перезагрузки возможна некорректная работа приложений." \
        --ok-label="Перезагрузить сейчас" \
        --cancel-label="Перезагрузить позже" \
        --window-icon=dialog-information \
        --width=520 \
        --height=140

    if [ $? -eq 0 ]; then
        reboot now
    fi
elif printf '%s\n' "$output" | grep -q "Перезагрузка не должна потребоваться"; then
    exit 0
fi

exit 0
