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
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!node_modules"'

function good_cd
    set chosen_dir (fzf --walker dir,follow,hidden  --walker-skip .git,node_modules,target,env)
    if [ $chosen_dir ]
        cd $chosen_dir
        commandline -f repaint
    end

end

bind \ce good_cd

# >>> coursier install directory >>>
set -gx PATH "$PATH:/home/pingutz/.local/share/coursier/bin"
# <<< coursier install directory <<<
pyenv init - | source
set -gx EMSDK_QUIET 1

if test -e "$HOME/emsdk/emsdk_env.fish"
    source $HOME/emsdk/emsdk_env.fish
end
