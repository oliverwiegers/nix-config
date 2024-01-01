####################################################################################
#     _____  _____ __  __   ________  ___   ______________________  _   _______    #
#    /__  / / ___// / / /  / ____/ / / / | / / ____/_  __/  _/ __ \/ | / / ___/    #
#      / /  \__ \/ /_/ /  / /_  / / / /  |/ / /     / /  / // / / /  |/ /\__ \     #
#     / /_____/ / __  /  / __/ / /_/ / /|  / /___  / / _/ // /_/ / /|  /___/ /     #
#    /____/____/_/ /_/  /_/    \____/_/ |_/\____/ /_/ /___/\____/_/ |_//____/      #
#                                                                                  #
####################################################################################

# Curl time lookup
clookup() {
    lookup_file="$(mktemp)"
    cat <<EOF > "${lookup_file}"
time_namelookup:    %{time_namelookup}\n
time_connect:       %{time_connect}\n
time_appconnect:    %{time_appconnect}\n
time_pretransfer:   %{time_pretransfer}\n
time_redirect:      %{time_redirect}\n
time_starttransfer: %{time_starttransfer}\n
                    --------\n
time_total:         %{time_total}\n
EOF

    curl -s -L $@ -w "@${lookup_file}" -o /dev/null
    rm "${lookup_file}"
}

# Create header for config files.
header() {
    header=$1
    file=$2

    figlet -f slant "${header}" >> "${file}"
}

# Get latest commit hash.
glc() {
    git log --format='%H' | sed 1q
}

# Get revision hash for external resource in home manager.
hgh() {
    home-manager switch --flake .#oliverwiegers@enigma \
        | grep 'got:' \
        | cut -d ' ' -f 2 \
        | cut -d '-' -f 2
}

_zsh_greeting() {
    if [ "$(uname)" = "Linux" ]; then
        if ! [ -f "$HOME/.local/no_greeting" ]; then

            shello.sh || true
            printf '\nTo disable the message above execute: "%s".\n' \
                'mkdir -p $HOME/.local && touch $HOME/.local/no_greeting'
        fi
    elif [ "$(uname)" = "Darwin" ]; then
        printf "And again. The Os of agony: macOS\n"
    else
        printf "Okay cool. Something different: \033[1;36m%s\n\033[0m" "$(uname)"
    fi
}
