if status is-interactive
    set -Ux MANPAGER 'nvim +Man!'
    fish_add_path /home/pingutz/bin
    fish_add_path /home/pingutz/.local/bin
    fish_add_path /home/pingutz/zig/
end

if not set -q NVIM
    starship init fish | source
end
fzf --fish | source
set -gx EDITOR nvim
alias jb="just build"
alias se="sudoedit"
direnv hook fish | source
pyenv init - | source
set -gx EMSDK_QUIET 1

if test -e "$HOME/emsdk/emsdk_env.fish"
    source $HOME/emsdk/emsdk_env.fish
end
