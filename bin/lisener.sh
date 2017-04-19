#!/bin/bash
#https://wiki.archlinux.org/index.php/Acpid

screen_path="/sys/class/backlight/intel_backlight/brightness"
max_screen_path="/sys/class/backlight/intel_backlight/max_brightness"

function led_screen(){
    max_screen_value="cut $max_screen_path"
    new_screen=$1
    if [[ $new_screen > 0 || $new_screen < $max_screen_value ]]; then
        echo $new_screen > $screen_path
    fi
}



acpi_listen | {
    while IFS= read -r line
    do
        #echo "$line"
        case $line in
            "ac_adapter ACPI0003:00 00000080 00000000")
                led_screen 100;
                ;;
            "ac_adapter ACPI0003:00 00000080 00000001")
                led_screen 900;
                ;;
            "jack/headphone HEADPHONE plug")
                /usr/bin/amixer -D pulse sset Master 40%
                ;;
            "jack/headphone HEADPHONE unplug")
                /usr/bin/amixer -D pulse sset Master 70%
                ;;
        esac
    done
}
