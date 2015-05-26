# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'googlestaticmap-clusters/version'

Gem::Specification.new do |spec|
  spec.name          = "googlestaticmap-clusters"
  spec.version       = GoogleStaticMapClusters::VERSION
  spec.authors       = ["Bruno Salerno"]
  spec.email         = ["br.salerno@gmail.com"]

  spec.summary       = 'Ruby gem to create Google Static Maps with clusters and markers'
  spec.description   = 'Add points layers, cluster them and get the link to the static map'
  spec.homepage      = 'https://github.com/BrunoSalerno/googlestaticmap-clusters'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "pixeldistance", "~> 0.2.1"
  spec.add_runtime_dependency "rclusters", "~> 0.2"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
