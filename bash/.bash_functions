# cd into a directory and ls content
function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -alF --color=auto
}

# Create a new directory and cd into it
mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}

# git commit
gcom ()
{
	if [ "$#" -lt 2 ]; then
    echo "Illegal number of parameters"
  else
		git commit -m "$*"
	fi
}
