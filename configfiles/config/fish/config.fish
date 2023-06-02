if status is-interactive
    # Commands to run in interactive sessions can go here
end

# adding PATHs

# homebrew on apple silicone
switch (uname)
    case Darwin
            fish_add_path /opt/homebrew/bin
    case '*'
            echo Skipped MacOs Setup
end

# custom Scripts folder

fish_add_path ~/Scripts

# vi mode
fish_vi_key_bindings

# custom greeting
set fish_greeting "Using Non-Posix compliant Fish Shell"

# abbreviations

# update software from packet managers

abbr -a -g apt-up "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y&& sudo apt clean -y"
abbr -a -g snap-up "sudo snap refresh"
# abbr -a -g pacman-up "sudo pacman -Syu"
# abbr -a -g yay-up "yay -Syu"
abbr -a -g brew-up "brew update && brew upgrade && brew cleanup"
abbr -a -g conda-up "conda update --all"
abbr -a -g pip-up "pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
abbr -a -g pkg-up "pkg update && pkg upgrade"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

# modified to work with different user names and conda versions
set -l USERS rmn roman
set -l CONDAS miniconda anaconda
set -l VERSIONS 2 3

for USER in $USERS
    for CONDA in $CONDAS
        for VERSION in $VERSIONS
            set -l path /Users/$USER/$CONDA$VERSION/bin/conda
            if test -f $path
                eval $path "shell.fish" "hook" $argv | source
                break 3
            end
        end
    end
end


# <<< conda initialize <<<

# show neofetch at startup
neofetch
