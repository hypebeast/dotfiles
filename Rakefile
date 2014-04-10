require 'rake'

desc "Hook our dotfiles into system standard positions."
task :install do
    puts
    puts "======================================================"
    puts "Welcome."
    puts "======================================================"
    puts

    install_homebrew if RUBY_PLATFORM.downcase.include?("darwin")
    run %{'bin/dot'} if RUBY_PLATFORM.downcase.include?("darwin")
    install_ohmyzsh
    install_spf13vim

    puts
    puts
    puts "======================================================"
    puts "Hooking up all dotfiles into system standard positions..."
    puts "======================================================"
    puts

    # Find all config files
    linkables = Dir.glob('*/**{.symlink}')
    zshplugins = Dir.glob('*/**{.plugin.zsh}')
    zshfiles = Dir.glob('*/**{.zsh}')
    #executables = Dir.glob('*/**{.sh}')

    # Remove all ZSH plugins
    zshfiles = zshfiles - zshplugins

    puts linkables
    puts zshplugins
    puts zshfiles

    process_symlinks(linkables)
    process_zsh_plugins(zshplugins)
    process_zsh_files(zshfiles)

    install_term_theme if RUBY_PLATFORM.downcase.include?("darwin")
    install_dircolors if RUBY_PLATFORM.downcase.include?("darwin")
end

desc 'Updates some spf13vim '
task :update do
    install_homebrew if RUBY_PLATFORM.downcase.include?("darwin")
    run %{'bin/dot'} if RUBY_PLATFORM.downcase.include?("darwin")
    #update_spf13vim
end

desc 'Setup gitconfig'
task :setup_gitconfig do
    # TODO
end

desc 'Run all dotfiles installers (install.sh)'
task :run_installers do
    scripts = linkables = Dir.glob('*/**{install.sh}')
    scripts.each do |script|
        puts "## Executing \"" + script + "\""
        `sh -c "#{script}"`
        puts
    end
end

desc 'Update brew packages'
task :update_brew do
    install_homebrew
end

task :default => 'install'

private
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def install_homebrew
  run %{which brew}
  unless $?.success?
    puts "======================================================"
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts "already installed, this will do nothing."
    puts "======================================================"
    run %{ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"}
  end

  puts
  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{brew update}

  puts
  puts
  puts "======================================================"
  puts "Installing Homebrew packages...There may be some warnings."
  puts "======================================================"
  run %{sh -c homebrew/install.sh}
  puts
  puts
end

def install_ohmyzsh
    puts "======================================================"
    puts "Installing oh-my-zsh, the open source, community-driven"
    puts "framework for managing your ZSH configuration..."
    puts "If it's already installed, this will do nothing."
    puts "======================================================"

    if File.directory?(File.expand_path("~/.oh-my-zsh"))
        puts "It looks like that oh-my-zsh is already installed."
    else
        run %{curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh}
    end
end

def install_spf13vim
    puts "======================================================"
    puts "Installing spf13-vim, the ultimate vim distribution..."
    puts "If it's already installed, this will do nothing."
    puts "======================================================"

    if File.directory?(File.expand_path("~/.spf13-vim-3"))
        puts "It looks like that spf13-vim is already installed."
    else
        run %{curl http://j.mp/spf13-vim3 -L -o - | sh}
    end
end

def install_dircolors
    puts "======================================================"
    puts "Installing dircolors..."
    puts "======================================================"

    run %{sh -c dircolors/install.sh}
end

def install_term_theme
  puts "======================================================"
  puts "Installing iTerm2 solarized theme."
  puts "======================================================"
  run %{ /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Light' dict" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Light.itermcolors' :'Custom Color Presets':'Solarized Light'" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Dark.itermcolors' :'Custom Color Presets':'Solarized Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist }

  # If iTerm2 is not installed or has never run, we can't autoinstall the profile since the plist is not there
  if !File.exists?(File.join(ENV['HOME'], '/Library/Preferences/com.googlecode.iterm2.plist'))
    puts "======================================================"
    puts "To make sure your profile is using the solarized theme"
    puts "Please check your settings under:"
    puts "Preferences> Profiles> [your profile]> Colors> Load Preset.."
    puts "======================================================"
    return
  end

  # Ask the user which theme he wants to install
  message = "Which theme would you like to apply to your iTerm2 profile?"
  color_scheme = ask message, iTerm_available_themes
  color_scheme_file = File.join('iTerm2', "#{color_scheme}.itermcolors")

  # Ask the user on which profile he wants to install the theme
  profiles = iTerm_profile_list
  message = "I've found #{profiles.size} #{profiles.size>1 ? 'profiles': 'profile'} on your iTerm2 configuration, which one would you like to apply the Solarized theme to?"
  profiles << 'All'
  selected = ask message, profiles

  if selected == 'All'
    (profiles.size-1).times { |idx| apply_theme_to_iterm_profile_idx idx, color_scheme_file }
  else
    apply_theme_to_iterm_profile_idx profiles.index(selected), color_scheme_file
  end
end

def iTerm_available_themes
   Dir['iTerm2/*.itermcolors'].map { |value| File.basename(value, '.itermcolors')}
end

def iTerm_profile_list
  profiles=Array.new
  begin
    profiles <<  %x{ /usr/libexec/PlistBuddy -c "Print :'New Bookmarks':#{profiles.size}:Name" ~/Library/Preferences/com.googlecode.iterm2.plist 2>/dev/null}
  end while $?.exitstatus==0
  profiles.pop
  profiles
end

def apply_theme_to_iterm_profile_idx(index, color_scheme_path)
  values = Array.new
  16.times { |i| values << "Ansi #{i} Color" }
  values << ['Background Color', 'Bold Color', 'Cursor Color', 'Cursor Text Color', 'Foreground Color', 'Selected Text Color', 'Selection Color']
  values.flatten.each { |entry| run %{ /usr/libexec/PlistBuddy -c "Delete :'New Bookmarks':#{index}:'#{entry}'" ~/Library/Preferences/com.googlecode.iterm2.plist } }

  run %{ /usr/libexec/PlistBuddy -c "Merge '#{color_scheme_path}' :'New Bookmarks':#{index}" ~/Library/Preferences/com.googlecode.iterm2.plist }
end

def ask(message, values)
  puts message
  while true
    values.each_with_index { |val, idx| puts " #{idx+1}. #{val}" }
    selection = STDIN.gets.chomp
    if (Float(selection)==nil rescue true) || selection.to_i < 0 || selection.to_i > values.size+1
      puts "ERROR: Invalid selection.\n\n"
    else
      break
    end
  end
  selection = selection.to_i-1
  values[selection]
end

# Process all linkable files. These files will get symlinked into your $HOME.
def process_symlinks(files)
    skip_all = false
    overwrite_all = false
    backup_all = false

    files.each do |linkable|
        skip = false
        overwrite = false
        backup = false

        file = linkable.split('/').last.split('.symlink')
        target = "#{ENV["HOME"]}/.%s" % file

        puts target

        if File.exists?(target) || File.symlink?(target)
            unless skip_all || overwrite_all || backup_all
                puts "File already exits: #{target}, what do you want to do? [s]skip, [S]kip all,[o]verwrite, [O]verwrite all, [b]backup, [B]ackup all?"

                case STDIN.gets.chomp
                when 's' then skip = true
                when 'o' then overwrite = true
                when 'b' then backup = true
                when 'O' then overwrite_all = true
                when 'B' then backup_all = true
                when 'S' then skip_all = true
                end
            end

            FileUtils.rm_rf(target) if overwrite || overwrite_all
            `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
        end

        # Create symlink
        `ln -s "$PWD/#{linkable}" "#{target}"` unless skip || skip_all
    end
end

# Process all ZSH plugins
def process_zsh_plugins(files)
    skip_all = false
    overwrite_all = false
    backup_all = false

    files.each do |zshfile|
        skip = false
        overwrite = false
        backup = false

        file = zshfile.split('/').last
        dir = zshfile.split('/').last.split('.plugin.zsh')
        target_dir = "#{ENV["HOME"]}/.oh-my-zsh/custom/plugins/%s" % dir
        target_file = "%s/%s" % [target_dir, file]

        if File.exists?(target_file) || File.symlink?(target_file)
            unless skip_all || overwrite_all || backup_all
                puts "File already exits: #{target_file}, what do you want to do? [s]skip, [S]kip all,[o]verwrite, [O]verwrite all, [b]backup, [B]ackup all?"

                case STDIN.gets.chomp
                when 's' then skip = true
                when 'o' then overwrite = true
                when 'b' then backup = true
                when 'O' then overwrite_all = true
                when 'B' then backup_all = true
                when 'S' then skip_all = true
                end
            end

            FileUtils.rm_rf(target_file) if overwrite || overwrite_all
            `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
        else
            # Create directory if it doesn't exists
            unless File.directory?(target_dir)
                Dir.mkdir(target_dir)
            end
        end

        # Create symlink
        `ln -s "$PWD/#{zshfile}" "#{target_file}"` unless skip || skip_all
    end
end

# Process all ZSH files
def process_zsh_files(files)
    skip_all = false
    overwrite_all = false
    backup_all = false

    files.each do |zshfile|
        skip = false
        overwrite = false
        backup = false

        file = zshfile.split('/').last
        target_dir = "#{ENV["HOME"]}/.oh-my-zsh/custom"
        target_file = "#{target_dir}/%s" % file

        if File.exists?(target_file) || File.symlink?(target_file)
            unless skip_all || overwrite_all || backup_all
                puts "File already exits: #{target_file}, what do you want to do? [s]skip, [S]kip all,[o]verwrite, [O]verwrite all, [b]backup, [B]ackup all?"

                case STDIN.gets.chomp
                when 's' then skip = true
                when 'o' then overwrite = true
                when 'b' then backup = true
                when 'O' then overwrite_all = true
                when 'B' then backup_all = true
                when 'S' then skip_all = true
                end
            end

            FileUtils.rm_rf(target_file) if overwrite || overwrite_all
            `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
        else
            # Create directory if it doesn't exists
            unless File.directory?(target_dir)
                Dir.mkdir(target_dir)
            end
        end

        # Create symlink
        `ln -s "$PWD/#{zshfile}" "#{target_file}"` unless skip || skip_all
    end
end

