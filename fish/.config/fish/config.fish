if status is-interactive
	fish_add_path "/home/pingutz/.local/bin"
	cd ~/Documents
end

starship init fish | source
fzf --fish | source

function good_cd;
	set chosen_dir (fzf --walker dir,follow,hidden  --walker-skip .git,node_modules,target,env)
	if [ $chosen_dir ];
		cd $chosen_dir
		commandline -f repaint
	end

end

function debug;
	echo $(pwd);
end;

bind \ce good_cd
