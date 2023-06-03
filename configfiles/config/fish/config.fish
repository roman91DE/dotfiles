if status is-interactive

    # show neofetch at startup
    neofetch

    # vi mode
    fish_vi_key_bindings

    # use a custom fish greeting that shows the version number
    function fish_greeting
        echo "fish version: "(fish --version | cut -d " " -f 3)
    end

end



# Linux specific setup
switch (uname)
    case Darwin
            set -gx fish_user_paths /opt/homebrew/bin
            abbr -a -g brew-up "brew update && brew upgrade && brew cleanup"
            echo MacOs Setup            
    case Linux
	    switch (uname -o)
		    case Android
                abbr -a -g pkg-up "pkg upgrade"
                echo Termux Setup
	        case (*)
                abbr -a -g apt-up "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y&& sudo apt clean -y"
                abbr -a -g snap-up "sudo snap refresh"
                abbr -a -g pacman-up "sudo pacman -Syu"
                abbr -a -g yay-up "yay -Syu"
                echo Linux Setup
        end
end

# (python) - pip specific setup
if command -v pip > /dev/null
    abbr -a -g pip-up "pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
end


# add custom Scripts folder to path
for dir in ~/Scripts ~/scripts 
    if test -d $dir
        set -gx fish_user_paths $dir
    end
end



# >>> conda initialize >>>
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
                abbr -a -g conda-up "conda update --all"
                break
            end
        end
    end
end
# <<< conda initialize <<<

