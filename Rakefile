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

desc "Run the unit tests"
task :test do
  require "#{File.dirname(__FILE__)}/test/test_rubylibcrack"
end

task :default => [ :test ]
