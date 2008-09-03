Gem::Specification.new do |s| 
  s.name = "filefinder"
  s.version = "0.0.8"
  s.author = "Thomas Peklak"
  s.email = "thomas.peklak@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "Finds files in directory and filters files through filters"
  s.files = ["bin/filefinder", "lib/FileFinder.rb"]
	s.bindir = 'bin'
	s.executable = 'filefinder'
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"] 
  s.rdoc_options = %w{--main README}
end