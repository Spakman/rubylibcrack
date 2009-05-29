desc "Builds the gem"
task :build do
  if ENV["VERSION"].nil?
    puts "You didn't specify a version number in the environment variable VERSION"
    exit -1
  end
  system "find #{File.dirname(__FILE__)} -type d -exec chmod -R 755 {} \\;"
  system "find #{File.dirname(__FILE__)} -type f -exec chmod -R 644 {} \\;"
  FileUtils.cp "rubylibcrack.gemspec", "rubylibcrack.gemspec.before_substitution", :preserve => true
  system "sed -i 's/%%%VERSION%%%/#{ENV["VERSION"]}/g' rubylibcrack.gemspec"
  system "gem build rubylibcrack.gemspec"
  FileUtils.mv "rubylibcrack-#{ENV["VERSION"]}.gem", "pkg/"
  FileUtils.mv "rubylibcrack.gemspec.before_substitution", "rubylibcrack.gemspec", :force => true
end

desc "Builds the extension"
task :build_extension => [ :clean_extension ] do
  system "cd ext; ruby extconf.rb; make; cd ../"
end

desc "Cleans the files compiled by build_extension"
task :clean_extension do
  system "cd ext; rm dictconfig.h rubylibcrack.so rubylibcrack.o Makefile; cd ../"
end

desc "Run the unit tests"
task :test => [ :build_extension ] do
  require "#{File.dirname(__FILE__)}/test/test_rubylibcrack"
end

task :default => [ :test ]
