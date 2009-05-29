require 'mkmf'
# Try to find an existing dictionary file to use as a default (currently we
# can't override this at runtime, but we should be able to in the future).
#
# This is *very* fragile, but I can't find a nicer way of doing this.

potential_dict_names = %w(pw_dict cracklib_dict)
potential_dict_paths = %w(/usr/share/cracklib/pw_dict /usr/lib64/cracklib_dict /var/cache/cracklib/cracklib_dict)
cracklib_dictpath = ""

locate_path = `which locate`.chomp
unless locate_path =~ / no locate in /
  #try using locate to find as many potential dict paths as possible
  potential_dict_names.each do |name|
    result = `#{locate_path} #{name}`.split("\n").each do |path|
      potential_dict_paths <<  path[0,path.length-4]
    end
  end
end
potential_dict_paths.uniq!

# Check the potential paths for the necessary file and stop as soon as one of
# the paths seems good.
potential_dict_paths.each do |path|
  if File.exists? path+".hwm" and File.exists? path+".pwd" and File.exists? path+".pwi"
    cracklib_dictpath = path
    break
  end
end

puts "  Building with CRACKLIB_DICTPATH #{cracklib_dictpath}, I hope that is correct!"

File.open(File.dirname(__FILE__)+'/dictconfig.h', "a") do |dictconfig|
  dictconfig << "#define DICTPATH \"#{cracklib_dictpath}\"\n"
end

$libs = append_library($libs, "crack")
create_makefile('rubylibcrack')
