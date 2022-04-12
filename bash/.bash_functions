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

mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}
