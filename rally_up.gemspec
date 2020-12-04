# frozen_string_literal: true

require_relative 'lib/rally_up/version'

Gem::Specification.new do |spec|
  spec.name          = 'rally_up'
  spec.version       = RallyUp::VERSION
  spec.authors       = ['David Richey']
  spec.email         = ['david.richey@memberhub.com']

  spec.summary       = 'RallyUp API & Partner API ruby gem'
  spec.description   = 'RallyUp API & Partner API ruby gem'
  spec.homepage      = 'https://github.com/memberhubteam/rally_up'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/memberhubteam/rally_up'
  spec.metadata['changelog_uri'] = 'https://github.com/memberhubteam/rally_up'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 4.0'

  spec.add_dependency 'http', '~> 4.0'
end
