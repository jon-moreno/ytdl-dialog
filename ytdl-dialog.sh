default_IFS=$IFS

#Receives Password and Index from user
#Using • as a separator since it is not a common keyboard character
inputs=$(\
		zenity --forms \
		--separator=• \
		--title="ytdl-dialog" \
		--text="Enter Parameters" \
		--add-entry="Playlist Stop Index" \
		--add-password="YT Account Password" \
)

declare -a preferences
let x=0

#Stores user input in array
IFS='•' #Changes IFS to parse Zenity output
for input in $inputs
do
	preferences[x]=$input
	let "x++"
done

#Stores prefences.txt in an array
IFS=$default_IFS
while read line; do
	preferences[x]=$line
	let "x++"
done < preferences.txt

#Variable Assignment
pl_end=${preferences[0]}
user=${preferences[2]}
pass=${preferences[1]}
encode=${preferences[3]}
wl_url="https://www.youtube.com/playlist?list=WL"

#The following command gets the top 1 thru $pl_end videos from WL
#My WL is sorted by date-added, newest first
youtube-dl --playlist-start 1 \
			--playlist-end $pl_end \
			--mark-watched \
			-w \
			--console-title \
			-f $encode \
			--recode-video mp4 \
			-c \
			-u $user \
			-p "$pass" \
			--embed-thumbnail \
			--restrict-filenames \
			-o "~/Videos/%(title)s.%(ext)s" \
			$wl_url \

#Switches

#Single Letter
  #w = do not overwrite existing files
  #c = continue partial downloads
  #f = format of encode (defined in preferences.txt)
  #o = output template

#For those who have not changed WL sort or have 2FA
  #--playlist-reverse
  #--max-downloads 10
  #-2