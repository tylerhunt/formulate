require './lib/formulate/version'

Gem::Specification.new do |spec|
  spec.name = 'formulate'
  spec.version = Formulate::VERSION
  spec.authors = ['Tyler Hunt']
  spec.summary = 'Rails form builder with flexible markup and styles.'
  spec.homepage = 'https://github.com/tylerhunt/formulate'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 1.9'

  spec.add_dependency 'actionpack', '~> 4.0'
  spec.add_dependency 'activesupport', '~> 4.0'
  spec.add_dependency 'carmen', '~> 0.2.0'
  spec.add_dependency 'haml', '~> 4.0'
  spec.add_dependency 'sass-rails', '~> 4.0'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'

  spec.files = `git ls-files`.split($\)
  spec.executables = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end
