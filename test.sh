#PASS=$(dialog --passwordbox "Enter YT Account Password" 10 10)
#echo $PASS
PASS =$(dialog --passwordbox "Enter YT Account Password" 0 0 \
	3>&1 1>&2 2>&3 3>&- \
)
echo $PASS
