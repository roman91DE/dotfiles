if status is-interactive
    # Commands to run in interactive sessions can go here
end

# adding PATHs

# homebrew on apple silicone
fish_add_path /opt/homebrew/bin


# vi mode
fish_vi_key_bindings

# custom greeting
set fish_greeting "Using Non-Posix compliant Fish Shell"

# abbreviations
abbr --add .git '/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/rmn/miniconda3/bin/conda
    eval /Users/rmn/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# use custom conda environment instead of base
conda activate DataScience


# show neofetch at startup
neofetch
