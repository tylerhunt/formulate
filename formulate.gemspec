require './lib/formulate/version'

Gem::Specification.new do |gem|
  gem.name = 'formulate'
  gem.version = Formulate::VERSION
  gem.summary = 'Rails form builder with flexible markup and styles.'
  gem.homepage = 'http://github.com/tylerhunt/formulate'
  gem.author = 'Tyler Hunt'

  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'actionpack', '>= 3.0'
  gem.add_dependency 'activesupport', '>= 3.0'
  gem.add_dependency 'sass-rails', '>= 3.0'
end
