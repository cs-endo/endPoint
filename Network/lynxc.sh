[[ -z $1 ]] && URL="lite.duckduckgo.com" || URL=$1
lynx -useragent='None' -scrollbar -show_rate -underline_links $URL
