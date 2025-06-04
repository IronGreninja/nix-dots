swayidle -w timeout 300 'swaylock -f -c 000000' \
            timeout 310 'hyprctl dispatch dpms off' \
            resume 'hyprctl dispatch dpms on' \
            timeout 350 'systemctl suspend' \
            before-sleep 'swaylock -f -c 000000' &
