require 'rubygems'
SPEC = Gem::Specification.new do |spec|
  spec.rubyforge_project = "rubylibcrack"
  spec.name = "rubylibcrack"
  spec.version = "%%%VERSION%%%" 
  spec.author = "Mark Somerville"
  spec.email = "mark@scottishclimbs.com"
  spec.homepage = "http://mark.scottishclimbs.com/"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "A binding to the *nix password strength checking library, libcrack/cracklib."
  spec.add_dependency('ffi')
  candidates = Dir.glob("{lib,test,ext}/**/*")
  spec.files = candidates
  spec.require_path = "lib"
  spec.has_rdoc = true
  spec.extra_rdoc_files = [ "README" ]
end
