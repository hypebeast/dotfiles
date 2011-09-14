require 'rake'

desc "Hook our dotfiles into system standard positions."

task :install do
    linkables = Dir.glob('*/**{.symlink}')
    zshfiles = Dir.glob('*/**{.zsh}')

    skip_all = false
    overwrite_all = false
    backup_all = false

    linkables.each do |linkable|
        skip = false
        overwrite = false
        backup = false

        file = linkable.split('/').last.split('.symlink')
        target = "#{ENV["HOME"]}/.#{file}"
        
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

        `ln -s "$PWD/#{linkable}" "#{target}"` unless skip || skip_all
    end

    skip_all = false
    overwrite_all = false
    backup_all = false

    zshfiles.each do |zshfile|
        skip = false
        overwrite = false
        backup = false

        file = zshfile.split('/').last
        dir = zshfile.split('/').last.split('.plugin.zsh')
        target_dir = "#{ENV["HOME"]}/.oh-my-zsh/custom/plugins/#{dir}"
        target_file = "#{target_dir}/#{file}"

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
            unless File.directory?(target_dir)
                Dir.mkdir(target_dir)
            end
        end

        `ln -s "$PWD/#{zshfile}" "#{target_file}"` unless skip || skip_all
    end
end

task :default => 'install'
