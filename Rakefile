require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  # dotfiles
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE].include? file
    next if file == 'config'

    path = ".#{file}"
    process_file(file, path, replace_all)
  end

  # .config dirs
  system %Q{mkdir -p "$HOME/.config"}
  Dir['config/*'].each do |file|
    path = ".config/#{file}"
    process_file(file, path, replace_all)
  end
end

def process_file(file, path, replace_all=false)
  if File.exist?(File.join(ENV['HOME'], "#{path.sub('.erb', '')}"))
    if File.identical? file, File.join(ENV['HOME'], "#{path.sub('.erb', '')}")
      puts "identical ~/#{path.sub('.erb', '')}"
    elsif replace_all
      replace_file(path)
    else
      print "overwrite ~/#{path.sub('.erb', '')}? [ynaq] "
      case $stdin.gets.chomp
      when 'a'
        replace_all = true
        replace_file(path)
      when 'y'
        replace_file(path)
      when 'q'
        exit
      else
        puts "skipping ~/#{path.sub('.erb', '')}"
      end
    end
  else
    link_file(path)
  end
end

def replace_file(path)
  system %Q{rm -rf "$HOME/#{path.sub(/.erb$/, '')}"}
  link_file(path)
end

def link_file(path)
  if path =~ /.erb$/
    puts "generating ~/#{path.sub(/.erb$/, '')}"
    File.open(File.join(ENV['HOME'], path.sub('.erb', '')), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/#{path}"
    system %Q{ln -s "$PWD/#{path}" "$HOME/#{path}"}
  end
end
