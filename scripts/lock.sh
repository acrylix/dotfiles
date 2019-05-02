TMPBG=/tmp/screen.png

# get current res (supports multi monitor)
RES=$( xrandr | sed 's/,/\n/g' | sed -n -e 's/^.*current //p' | sed -e "s/ //g")
 
# grab and blur
ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY \
    -filter_complex "boxblur=10:5" -vframes 1 $TMPBG

FG=$(awk '/color3:(.*)/ { print $2 }' < ~/.Xresources)
FF=$FG"ff"
        
font="hack"
B='#00000000'  # blank
C='#badc58ff'  # clear ish
D='#95afc0ff'  # default
T=$FF  # text
W='#e74c3cff'  # wrong
V='#2ecc71ff'  # verifying

i3lock-color \
-i "$TMPBG" \
--radius=20 --ring-width=10 \
--indpos="x+(w/2):y+(h/2)+100" \
--timepos='x+(w/2):y+(h/2)' \
--datepos='x+(w/2):y+(h/2)+50' \
--timesize=80 \
--datesize=30 \
--veriftext='' --wrongtext='' \
--time-font="$font" --date-font="$font" --layout-font="$font" --verif-font="$font" --wrong-font="$font" \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=$T       \
--bshlcolor=$W        \
\
--screen 1            \
--clock               \
--indicator           \
--timestr="%I:%M:%S %p"  \
--datestr="%A %b %d %Y"