
function toAPI {
	# $1 = File to point to
	# $2 = extension to base URL

	while read line; do
		[[ "$line" =~ ": " ]] && { echo "HEADER: ${line/ /}"; continue; }
		[[ "$line" =~ "= " ]] && { reqURL+="&${line/ /}"; continue; }

		case "$line" in
		  GET | POST)
			reqVerb="$line"; ;;
		  *)
			reqURL="$line/$2?";  ;;
		esac
	done <$1

	reqURL="${reqURL/?&/?}"

	curl -X "$reqVerb" \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
"$reqURL"
	echo -e "\n"

}

toAPI $@


# File example
# https://google...... # A base URL
# VERB
# key1= VALUE # in URL
# key2= VALUE # in URL
# key3: VALUE # in header
