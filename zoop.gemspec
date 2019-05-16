lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoop/version'

Gem::Specification.new do |spec|
  spec.name          = 'zoop'
  spec.version       = Zoop::VERSION
  spec.authors       = ['Rodrigo Mageste']
  spec.email         = ['rodrigo.mgst@gmail.com']

  spec.summary       = %q{Zoop's ruby gem}
  spec.description   = %q{Allows integration with Zoop}
  spec.homepage      = 'https://zoop.co/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',      '~> 2.0'
  spec.add_development_dependency 'rake',         '~> 10.0'
  spec.add_development_dependency 'rspec',        '~> 3.0'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'cpf_faker'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'rest-client'
  spec.add_dependency 'multi_json'
end
