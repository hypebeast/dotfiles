require 'rake'


desc "First time installation of basic applications, tools and frameworks"
task :bootstrap do
    puts
    puts "======================================================".green
    puts "Welcome.".green
    puts
    puts "Installing all required programs, tools and frameworks.".green
    puts "======================================================".green
    puts

    install_homebrew if is_darwin
    install_ohmyzsh
    install_zshplugins
    install_spf13vim

    run_installers
    dot if is_darwin
    install_term_theme if is_darwin
    install_dircolors if is_darwin
end

desc "Hook our dotfiles into system standard positions."
task :install do
    puts
    puts "=========================================================".green
    puts "Hooking up all dotfiles into system standard positions...".green
    puts "=========================================================".green
    puts

    symlinks = find_symlinks
    plugins = find_zshplugins
    zsh = find_zshfiles
    linkable_dirs = find_linkabledirs

    all = symlinks + plugins + zsh + linkable_dirs
    link_files(all)
end

desc 'Set Mac OS X default options'
task :dot do
    dot
end

desc 'Run all installer scripts (install.sh)'
task :run_installers do
    run_installers
end

desc 'Update brew packages'
task :update_brew do
    install_homebrew if RUBY_PLATFORM.downcase.include?("darwin")
end

task :default => 'install'


private


###########################################################
## Install tasks
###########################################################

def install_homebrew
  run %{which brew}
  unless $?.success?
    puts "======================================================"
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts "already installed, this will do nothing."
    puts "======================================================"
    run %{/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  end

  puts
  puts
  puts "======================================================"
  puts "Installing Brew packages...There may be some warnings."
  puts "======================================================"
  run %{sh -c homebrew/brew.sh}
  puts
  puts

  puts
  puts
  puts "======================================================"
  puts "Installing brew-cask packages...There may be some warnings."
  puts "======================================================"
  run %{sh -c homebrew/brew-cask.sh}
  puts
  puts
end

# Install required packages via apt
def install_apt_packages
    # TODO
end

# Install oh-my-zsh
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

def install_zshplugins
    puts "======================================================"
    puts "Installing some more zsh plugins."
    puts "The following plugins are going to be installed:"
    puts " - zsh-syntax-highlighting"
    puts "======================================================"

    if File.directory?(File.expand_path("~/.oh-my-zsh"))
        puts "It looks like that oh-my-zsh is not installed."
    else
        run %{cd ~/.oh-my-zsh/custom/plugins; git clone git://github.com/zsh-users/zsh-syntax-highlighting.git}
    end
end

def install_dircolors
    puts "======================================================"
    puts "Installing dircolors..."
    puts "======================================================"

    run %{sh -c dircolors/install.sh}
end

def run_installers
  puts
  puts "======================================================"
  puts "Running all installer scripts..."
  puts "======================================================"
  puts

  scripts = Dir.glob('*/**{install.sh}')
  scripts.each do |script|
      puts "## Executing \"" + script + "\""
      `sh -c "#{script}"`
      puts
  end
end

def dot
  run %{'bin/dot'} if RUBY_PLATFORM.downcase.include?("darwin")
end


###########################################################
## iTerm specific functions
###########################################################

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


###########################################################
## Helper functions
###########################################################

# Run a command
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

# Ask a question and provides a selection
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

# Return true, if the system is Darwin
def is_darwin()
    RUBY_PLATFORM.downcase.include?("darwin")
end

# Return true, if the system is Linux
def is_linux()
    RUBY_PLATFORM.downcase.include?("linux")
end


###########################################################
## Colorfull strings
###########################################################

class String
    def black;          "\e[30m#{self}\e[0m" end
    def red;            "\e[31m#{self}\e[0m" end
    def green;          "\e[32m#{self}\e[0m" end
    def brown;          "\e[33m#{self}\e[0m" end
    def blue;           "\e[34m#{self}\e[0m" end
    def magenta;        "\e[35m#{self}\e[0m" end
    def cyan;           "\e[36m#{self}\e[0m" end
    def gray;           "\e[37m#{self}\e[0m" end

    def bg_black;       "\e[40m#{self}\e[0m" end
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_brown;       "\e[43m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_gray;        "\e[47m#{self}\e[0m" end

    def bold;           "\e[1m#{self}\e[22m" end
    def italic;         "\e[3m#{self}\e[23m" end
    def underline;      "\e[4m#{self}\e[24m" end
    def blink;          "\e[5m#{self}\e[25m" end
    def reverse_color;  "\e[7m#{self}\e[27m" end
end
