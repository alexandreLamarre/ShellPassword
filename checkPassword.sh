function checkPassword {
if [ ${#1} -lt 8 ] ; then
	echo 'weak password: must contain at least 8 characters'
fi

if echo "$1" | grep -q "\(.\).*\1" ; then
	echo 'weak password: must not contain duplicate characters'
fi

if ! [[ $1 =~ [a-z] ]]; then
	echo 'weak password: must contain lowercase'
fi

if ! [[ $1 =~ [A-Z] ]]; then
	echo 'weak password: must contain uppercase'
fi

if ! [[ $1 =~ [0-9] ]] ; then
	echo 'weak password: must contain digits'
fi
}
