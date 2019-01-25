#!/bin/bash

ip="192.168.1.6"
folder="/home/pi/RetroPie/roms/moonlight/"
eval "moonlight list $ip" | while read -r line ; do
        if ! [[ $line =~ ^[0-9] ]]; then
                if [[ $line == Connect\ to\ * ]]; then
                        echo "Found games, removing old files"
                        `rm -f $folder*`
                fi
                continue
        fi
        name=${line#* }
        printf "#!/bin/bash\nmoonlight stream -1080 -fps 60 -app \"$name\" $ip\n" > "$folder$name.sh"
done
eval "chmod 775 $folder*"
