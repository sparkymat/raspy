# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'raspy/version'

Gem::Specification.new do |spec|
  spec.name          = "raspy"
  spec.version       = Raspy::VERSION
  spec.authors       = ["Ajith Hussain"]
  spec.email         = ["csy0013@googlemail.com"]

  spec.summary       = %q{raspy adds a prefetch mechanism to ActiveRecord which is parallel to the ActiveRecord associations.}
  spec.homepage      = "https://github.com/sparkymat/raspy"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activerecord", [">= 4.0.0"])
  spec.add_dependency("rusql", [">=  1.0.5"])

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
