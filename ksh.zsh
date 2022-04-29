NEWLINE="
"

kshell() {
	KSH_PROMPT="$NEWLINE"

	KSH_CWD_LINE=" 📂 %B%F{cyan}%~%F{reset}%b"
	KSH_PROMPT="$KSH_PROMPT$KSH_CWD_LINE"

	KSH_CWD_CONTEXT=""

	if [ -d ".git" ]; then
		KSH_GIT_TOKEN="%B%F{red}git%f%b: $(git branch --show-current)"

		KSH_CWD_CONTEXT="$KSH_CWD_CONTEXT $KSH_GIT_TOKEN"
	fi

	if [ -f "package.json" ]; then
		KSH_NPM_TOKEN="%B%F{red}npm%f%b: $(npm --version)"
		KSH_NODE_TOKEN="%B%F{green}node%f%b: $(node --version)"

		KSH_CWD_CONTEXT="$KSH_CWD_CONTEXT $KSH_NPM_TOKEN $KSH_NODE_TOKEN"
	fi

	if [ ! -z "$KSH_CWD_CONTEXT" ]; then
		KSH_PROMPT="$KSH_PROMPT$NEWLINE 💡$KSH_CWD_CONTEXT"
	fi

	KSH_INPUT_LINE="$NEWLINE %B%F{magenta}> %F{reset}%b"
	KSH_PROMPT="$KSH_PROMPT$KSH_INPUT_LINE"

	PROMPT="$KSH_PROMPT"
}

# append the function to our array of precmd functions
precmd_functions+=kshell
kshell
