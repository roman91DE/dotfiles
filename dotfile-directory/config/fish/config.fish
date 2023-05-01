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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/rmn/miniconda3/bin/conda
    eval /Users/rmn/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# show neofetch at startup
neofetch
