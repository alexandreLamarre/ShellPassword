# ShellPassword
Simple Solution for shell function checking weak password.

The hardest part about this problem was figuring out how to check for duplicate characters. Being nervous during the interview, I didn't think of regex groups.
Defining a matching pattern group in regex can be done using parentheses: 
- For example `(.)` will match any one character or `(?)` will match one or more characters.
- In bash we have to use the escape character `\` to use groups or else the Shell will interpret `(` as the builtin function which creates a new subshell process.
- So we get `\(.\)` to match any character and tell the regex to index this as **Group 1**.

Finally we use the Kleene star  `.*` to match any number of characters until we encounter the first group character which we can reference using this regex notation `\1`. We use the grep -q flag to return as soon as we find a match, instead of finding all matches.


I also did some research to figure out the easy way of getting a variables length using the builtin `#`, which will definitely make future shell scripts easier.

The rest is simple regex as pointed by Harry, using the bash shorthand ``[[ ]]``.

We can of course use `&&` these together to fit in one statement as the original problem describes.

While doing research, I also found out that you can use the Posix character class [:alnum:] to match to any alphanumeric character. So an alternative solution to checking duplicate characters would use `` if [[ $1 =~ [[:alnum:]].*[[:alnum:]] ]] ; then``, to produce a more "bash-readable" solution.



## Code

```function checkPassword {
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
```
