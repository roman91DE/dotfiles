if status is-interactive

    # OS specific setup
    switch (uname)
        case Darwin     # MacOs
                set -gx fish_user_paths /opt/homebrew/bin
                abbr -a -g ,brew-up "brew update ; brew upgrade ; brew cleanup"
                echo MacOs Setup            
        case Linux
            switch (uname -o)
                case Android    # Termux/Linux Emulator
			set -gx fish_user_paths /data/data/com.termux/files/home/.shortcuts
                        abbr -a -g ,pkg-up "pkg upgrade"
			abbr -a -g ,run-debian "proot-distro login debian --termux-home"
                        echo Termux Setup
                    case '*'    # Linux
                        abbr -a -g ,apt-up "sudo apt update ; sudo apt upgrade -y ; sudo apt autoremove -y; sudo apt clean -y"
                    abbr -a -g ,snap-up "sudo snap refresh"
                    abbr -a -g ,pacman-up "sudo pacman -Syu"
                    abbr -a -g ,yay-up "yay -Syu"
                    echo Linux Setup
            end
    end

    # test if nvim is installed and if so, set an abbreviation for nvimnto vim
    if command -v nvim > /dev/null
	    echo replacing vim with neovim
	    abbr -a -g vim "nvim"
    end
    
    

    # (python) - pip specific setup
    if command -v pip > /dev/null
        abbr -a -g ,pip-up "pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
    end


    # add all script directories to the path
    set -gx fish_user_paths $fish_user_paths (find ~/ -maxdepth 1 -type d -iname "*script*" | tr '\n' ' ')


    # modified conda initialize to work with different user names and conda versions
    set -l USERS rmn roman
    set -l CONDAS miniconda anaconda
    set -l VERSIONS 2 3

    for USER in $USERS
        for CONDA in $CONDAS
            for VERSION in $VERSIONS
                set -l path /Users/$USER/$CONDA$VERSION/bin/conda
                if test -f $path
                    eval $path "shell.fish" "hook" $argv | source
                    abbr -a -g ,conda-up "conda update --all"
                    break
                end
            end
        end
    end



    # show neofetch at startup
    neofetch

    # set the default editor
    set -gx EDITOR vim

    # set the default pager
    set -gx PAGER less

    # add abbreviations for git add * ; git commit -m "message" ; git push where message is the date and time of the commit
    abbr -a -g ,gacp "git add * ; git commit -m (date +%Y-%m-%d_%H:%M:%S) ; git push"

    # vi keybindings
    fish_vi_key_bindings

    # use a custom fish greeting that shows the version number
    function fish_greeting
        echo "fish version: "(fish --version | cut -d " " -f 3)
    end

end

