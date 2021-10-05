require_relative 'lib/coinmarketcap/version'

Gem::Specification.new do |spec|
  spec.name          = 'coinmarketcap-ruby-client'
  spec.version       = CoinMarketCap::VERSION
  spec.authors       = ['Mathusan Selvarajah']
  spec.email         = ['mathusans52@gmail.com']

  spec.summary       = 'CoinMarketCap API Ruby client.'
  spec.description   = 'An actively maintined Ruby Client for CoinMarketCap API'
  spec.homepage      = 'https://github.com/koffeefinance/coinmarketcap-ruby-client'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/koffeefinance/coinmarketcap-ruby-client'
  spec.metadata['changelog_uri'] = 'https://github.com/koffeefinance/coinmarketcap-ruby-client/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>= 1.8'
  spec.add_dependency 'faraday_middleware', '>= 1.1'
  spec.add_dependency 'hashie'
  spec.add_development_dependency 'mocha', '~> 1.13'
  spec.add_development_dependency 'rubocop', '0.72.0'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.14'
end
