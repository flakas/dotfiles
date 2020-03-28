#!/usr/bin/ruby
path = "/tmp/fake-mailer"
Dir.mkdir(path) if !File.exists?(path)
File.open("#{path}/#{Time.now.to_f}.txt", "w") do |f|
    f.puts ARGV.inspect
    $stdin.each_line { |line| f.puts line }
end
