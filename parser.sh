#!/bin/bash

find "$HOME/.purple/logs/jabber" -type f |while read -r f; do
	#2017-05-17.220248+0200CEST.html
	base=$(basename "$f")
	# init year month day
	y=$(echo "$base" |cut -c 1-4)
	m=$(echo "$base" |cut -c 6-7)
	d=$(echo "$base" |cut -c 9-10)
	last_h=0
	x=$(cat "$f" |tail -n +2 |
		sed -E 's/><\/?p></></g' |
		html2text.py --ignore-links --ignore-images --dash-unordered-list --body-width=0)
	echo "$x" |sed -E '/^ *$/d' |while read -r l; do
		#(22:49:48) **phi:** hm
		h=$(echo "$l" |cut -c 2-3)
		mi=$(echo "$l" |cut -c 5-6)
		s=$(echo "$l" |cut -c 8-9)
		is_number_re='^[0-9]{2}$'
		if [[ $h =~ $is_number_re ]] && [[ $m =~ $is_number_re ]] && [[ $s =~ $is_number_re ]]; then
			# valid new line
			body=$(echo "$l" |cut -c 12-)
			if [[ $h -lt $last_h ]]; then # hour decreased: increment day
				read y m d <<< $(date +'%Y %m %d' --date="$y-$m-$d +1 day") # update y m d
			fi
			echo -n $'\n'"$y-$m-$d $h:$mi:$s $body"
			last_h=$h
		else
			# continous line: add <br> and concat
			echo -n "<br>$l"
		fi
	done
	echo -n $'\n'
done |sort
