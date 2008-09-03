Gem::Specification.new do |s| 
  s.name = "filefinder"
  s.version = "0.0.8"
  s.author = "Thomas Peklak"
  s.email = "thomas.peklak@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "Finds files in directory and filters files through filters"
  s.files = Dir["{bin,lib}/**/*"].to_a
	s.bindir = 'bin'
	s.executable = 'filefinder'
  s.require_path = "lib"
  s.has_rdoc = true
end