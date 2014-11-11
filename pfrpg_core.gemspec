$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pfrpg_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pfrpg_core"
  s.version     = PfrpgCore::VERSION
  s.authors     = ["Jordan OMara"]
  s.email       = ["jordan@herosheets.com"]
  s.homepage    = "http://herosheets.com"
  s.summary     = "PFRPG core"
  s.description = "core"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"
end

