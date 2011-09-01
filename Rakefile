require 'rake'

desc "Hook our dotfiles into system standard positions."

task :install do
    linkables = Dir.glob('*/**{.symlink}')
    zshfiles = Dir.glob('*/**{.zsh}')

    linkables.each do |linkable|
        puts linkable

        file = linkable.split('/').last.split('.symlink')
        puts file
        target = "#{ENV["HOME"]}/.#{file}"
        puts target
    end

    zshfiles.each do |zshfile|
        puts zshfile        

        file = zshfile.split('/').last
        puts file
    end
end

task :default => 'install'
