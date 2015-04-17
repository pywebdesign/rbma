$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rbma/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rbma"
  s.version     = Rbma::VERSION
  s.authors     = ["Pierre-Yves Mathieu"]
  s.email       = ["git@pywebdesogn.net"]
  s.homepage    = "https://github.com/pywebdesign/rbma"
  s.summary     = "Many moving averages function, both recursive and non recursive"
  s.description = "(SimpleMA) Moving average over last n day, (EMA) Exponential moving average, (IEMA) Exponential moving average on irregularly timed events series, N days EMA, Cumulative EMA"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rails", "~> 4.2.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry-rails"
end
