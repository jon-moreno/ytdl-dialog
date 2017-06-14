
pl_end=$(dialog --form "Playlist Stop" 0 0 0 \
		"Username:" 1 1	"$user" 	1 10 10 0 \
		3>&1 1>&2 2>&3 3>&- \
)

#--passwordbox  <text> <height> <width> [<init>]
pass=$(dialog --passwordbox "Enter YT Account Password" 0 0 \
	3>&1 1>&2 2>&3 3>&- \
)
clear

declare -a preferences
let x=0
while read line; do    
	preferences[x]=$line
	let "x++"
done < preferences.txt

pl_end=10
user=${preferences[0]} #First line of credentials.txt
encode=${preferences[1]}
wl_url="https://www.youtube.com/playlist?list=WL"

#youtube-dl [OPTIONS] URL [URL...]
youtube-dl -s \
			--playlist-start 1 \
			--playlist-end $pl_end \
			--mark-watched \
			-w \
			--console-title \
			-f $encode \
			-c \
			-u $user \
			-p $pass \
			--embed-thumbnail \
			$wl_url \

#youtube-dl --playlist-reverse --max-downloads 10 --mark-watched $WL_URL

#Swithces
#w = do not overwrite existing files
#c = continue partial downloads
#f = format of encode (defined in preferences.txt)
			#--playlist-reverse
			#--max-downloads 10
						#-2 $2FA