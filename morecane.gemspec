Gem::Specification.new do |s|
  s.name              = "morecane"
  s.version           = "0.1.0"
  s.summary           = "Extra checks for the cane gem"
  s.description       = "A set of common checks that I use with cane across my projects"
  s.author            = "James Healy"
  s.email             = ["james@yob.id.au"]
  s.homepage          = "http://github.com/yob/morecane"
  s.has_rdoc          = true
  s.rdoc_options      << "--title" << "Morecane" << "--line-numbers"
  s.files             = Dir.glob("lib/**/*") + Dir.glob("bin/*") + ["README.rdoc", "CHANGELOG"]
  s.required_rubygems_version = ">=1.3.2"
  s.required_ruby_version = ">=1.8.7"

  s.add_dependency("cane", ">=2.1.0")

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec",   "~>2.3")
end
