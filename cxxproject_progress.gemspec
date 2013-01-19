# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cxxproject_progress/version'

Gem::Specification.new do |gem|
  gem.name          = "cxxproject_progress"
  gem.version       = CxxprojectProgress::VERSION
  gem.authors       = ["Christian Köstlin"]
  gem.email         = ["christian.koestlin@esrlabs.com"]
  gem.description   = %q{a ascii-art progressbar for the build progress}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'progressbar'
end
