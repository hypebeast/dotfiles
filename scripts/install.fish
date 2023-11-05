#!/usr/bin/env fish

set DOTFILES_ROOT (pwd -P)

source ./scripts/functions.fish

function link_file -d "links a file keeping a backup"
	echo $argv | read -l src dst backup
    
	if test -e $dst
		set dstf (readlink $dst)

		if test "$dstf" = "$src"
			success "skipped $src"
			return
		else
			mv $dst $dst.$backup
				and success moved $dst to $dst.$backup
				or abort "failed to backup $dst to $dst.$backup"
		end
	end

	mkdir -p (dirname $dst)
		and ln -sf $src $dst
		and success "linked $src to $dst"
		or abort "could not link $src to $dst"
end

function install_dotfiles
	# Link all config files
	for src in $DOTFILES_ROOT/*/*.symlink
		link_file $src $HOME/.(basename $src .symlink) backup
			or abort 'failed to link config file'
	end

	# Fish config files
	link_file $DOTFILES_ROOT/fish/plugins $__fish_config_dir/fish_plugins backup
		or abort "Fish plugins"
	link_file $DOTFILES_ROOT/fish/config.fish $__fish_config_dir/config.fish backup
		or abort "Fish config"

	# Ripgrep
	link_file $DOTFILES_ROOT/ripgrep/rg.conf $HOME/.config/ripgrep/rg.conf backup

  # Hammerspoon
	link_file $DOTFILES_ROOT/hammerspoon/.hammerspoon $HOME/.hammerspoon backup

	# Nvim
	# link_file $DOTFILES_ROOT/nvim/config $HOME/.config/nvim backup

	# link_file $DOTFILES_ROOT/system/bat.config $HOME/.config/bat/config backup
	# 	or abort bat
	# link_file $DOTFILES_ROOT/htop/htoprc $HOME/.config/htop/htoprc backup
	# 	or abort htoprc
	# link_file $DOTFILES_ROOT/ssh/config.dotfiles $HOME/.ssh/config.dotfiles backup
	# 	or abort ssh-config
	# link_file $DOTFILES_ROOT/ssh/rc $HOME/.ssh/rc backup
	# 	or abort ssh-rc
	# link_file $DOTFILES_ROOT/kitty/kitty.conf $HOME/.config/kitty/kitty.conf backup
	# 	or abort kitty
	# link_file $DOTFILES_ROOT/kitty/macos-launch-services-cmdline $HOME/.config/kitty/macos-launch-services-cmdline backup
	# 	or abort kitty
	# link_file $DOTFILES_ROOT/wezterm $HOME/.config/wezterm backup
	# 	or abort wezterm
	# link_file $DOTFILES_ROOT/yamllint/config $HOME/.config/yamllint/config backup
	# 	or abort yamllint
end

# Install Fisher package manager
curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
	and success 'Finished installing Fisher'
	or abort 'Failed installing Fisher'

# Symlink all dotfiles
install_dotfiles
	and success 'Finished installing all dotfiles'
	or abort 'Failed installing dotfiles'

# Update Fish plugins
fisher update
	and success 'Finished installing Fisher plugins'
	or abort 'Failed intsalling Fisher plugins'

# Set theme
#yes | fish_config theme save "Catppuccin Mocha"
#	and success 'Finished install Fish colorscheme'
#	or abort 'Failed installing Fish colorscheme'

# Ensure completions directory exist
mkdir -p $__fish_config_dir/completions/
	and success 'completions'
	or abort 'completions'

# Ensure bin directory exist
mkdir -p ~/.bin 
	and success 'creating bin dir'
	or abort 'creating bin dir'

# Run bootstrap installer
$DOTFILES_ROOT/fish/bootstrap.fish
	and success 'Finished running initial Fish bootstrap script'
	or abort 'Failed running initial Fish bootstrap script'

# Run all installers
for installer in */install.fish
  # Skipt the main installer script
  if string match -q 'scripts*' $installer
    continue
  end

	$installer
		and success $installer
		or abort $installer
end

if ! grep (command -v fish) /etc/shells
	command -v fish | sudo tee -a /etc/shells
		and success 'added fish to /etc/shells'
		or abort 'setup /etc/shells'
	echo
end

test (which fish) = $SHELL
	and success 'dotfiles installed/updated!'
	and exit 0

chsh -s (which fish)
	and success set (fish --version) as the default shell
	or abort 'set fish as default shell'

success 'dotfiles installed/updated!'
