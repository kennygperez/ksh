NEWLINE="
"

kshell() {
	KSH_PROMPT="$NEWLINE"

	KSH_CWD_LINE=" 📂 %B%F{cyan}%~%F{reset}%b"
	KSH_PROMPT="$KSH_PROMPT$KSH_CWD_LINE"

	KSH_CWD_CONTEXT=""

	# GIT
	if [ -d ".git" ]; then
		KSH_GIT_TOKEN="%B%F{red}git%f%b: $(git branch --show-current)"

		KSH_CWD_CONTEXT="$KSH_CWD_CONTEXT $KSH_GIT_TOKEN"
	fi

	# Node Package JSON
	if [ -f "package.json" ]; then
		KSH_NPM_TOKEN="%B%F{red}npm%f%b: $(npm --version)"
		KSH_NODE_TOKEN="%B%F{green}node%f%b: $(node --version)"

		KSH_CWD_CONTEXT="$KSH_CWD_CONTEXT $KSH_NPM_TOKEN $KSH_NODE_TOKEN"
	fi

	# Yarn
	if [ -f "yarn.lock" ]; then
		KSH_YARN_TOKEN="%B%F{blue}yarn%f%b: $(yarn --version)"

		KSH_CWD_CONTEXT="$KSH_CWD_CONTEXT $KSH_YARN_TOKEN"
	fi

	# GO
	if [ -f "go.mod" ]; then
		KSH_GO_TOKEN="%B%F{blue}go%f%b: $(go version)"

		KSH_CWD_CONTEXT="$KSH_CWD_CONTEXT $KSH_GO_TOKEN"
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
