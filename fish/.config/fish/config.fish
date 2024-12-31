if status is-interactive
	cd ~/Documents
end

starship init fish | source
fzf --fish | source

function good_cd;
	set chosen_dir (fzf --walker dir,follow,hidden  --walker-skip .git,node_modules,target,env)
	if set -q chosen_dir;
		cd $chosen_dir
		commandline -f repaint;
	end
end

bind \ce good_cd
