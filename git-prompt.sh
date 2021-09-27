# add this to GITPATH/etc/profile.d/git-prompt.sh
if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
	PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'\[\033[1;32m\]'       # change to green
	PS1="$PS1"'\u'
	PS1="$PS1"' \[\033[0m\]'  # reset color
	PS1="$PS1"'\[\033[1;35m\]'  # add purple
	PS1="$PS1"'\w'                 # current working directory
	PS1="$PS1"' \[\033[0m\]'  # reset color
	PS1="$PS1"'\[\033[1;31m\]'  # add red color
	# add files and file size
	PS1="$PS1"'(`ls -fA . | wc -l`files-`ls -lAh | grep -m 1 total | sed "s/total //"`)'
	PS1="$PS1"'\[\033[0m\]'  # reset color
	PS1="$PS1"'\[\033[0m\]'
	# add git info
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[1;36m\]'  # change color to cyan
			#PS1="$PS1"'`__git_ps1`'   # bash function
		fi
	fi
	PS1="$PS1"'\[\033[0m\] '  # reset color
	# Check for git environment and staged and unstaged files
	PS1="$PS1"'`if [[ "$(git rev-parse --git-dir 2> /dev/null | wc -l)" = 1 ]]; then if [[ -n $(git status -s) ]]; then echo "\[\033[1;36m\]($(git rev-parse --abbrev-ref HEAD 2> /dev/null) \[\033[1;37m\]$(git status -s | grep -w "A" | wc -l)S|\e[0m$(git status -s | grep -w "?" | wc -l)U|\[\033[1;33m\]$(git status -s | grep -w "M" | wc -l)M\[\033[1;36m\]"; else echo "\[\033[1;36m\]($(git rev-parse --abbrev-ref HEAD 2> /dev/null)"; fi fi`'
	#Check if repo is ahead, behind, equal or diverged
	PS1="$PS1"'`if [[ "$(git rev-parse --git-dir 2> /dev/null | wc -l)" = 1 ]]; then if [[ "$(git config --get remote.origin.url 2> /dev/null | wc -l)" = "1" ]]; then if [[ "$(git rev-parse HEAD 2> /dev/null)" = "$(git rev-parse origin/$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 2> /dev/null)" ]]; then echo "|=) "; else if [[ "$(git rev-parse HEAD 2> /dev/null)" = "$(git merge-base HEAD origin/$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 2> /dev/null)" ]]; then echo "|<) "; else if [[ "$(git rev-parse origin/$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 2> /dev/null)" = "$(git merge-base HEAD origin/$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 2> /dev/null)" ]]; then echo "|>) "; else echo "|<>) "; fi fi fi else echo ") "; fi fi`'
	# test virtual env
	PS1="$PS1"'\[\033[1;34m\]`if [[ -n $CONDA_DEFAULT_ENV ]]; then echo "($(basename $CONDA_DEFAULT_ENV 2> /dev/null)|Python $($CONDA_DEFAULT_ENV/python.exe -c "import platform; print(platform.python_version())" 2> /dev/null))"; fi; if [[ -n $VIRTUAL_ENV ]]; then echo "($(basename $VIRTUAL_ENV 2> /dev/null)|Python $($VIRTUAL_ENV/python.exe -c "import sys;v=sys.version_info;print(v.major,v.minor,v.micro)" 2> /dev/null))"; fi`'	
	PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'\[\033[1;36m\]'  # change color to blueish
	PS1="$PS1"'-->: '                 # prompt:└|>
	PS1="$PS1"'\[\033[0m\]'  # reset color
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi
