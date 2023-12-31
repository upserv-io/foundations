# frozen_string_literal: true

require_relative 'lib/upserv_foundations/version'

Gem::Specification.new do |spec|
  spec.name = 'upserv_foundations'
  spec.version = UpservFoundations::VERSION
  spec.authors = ['Clark Taylor']
  spec.email = ['clark@upserv.io']

  spec.summary = 'Add all the things you would want by default in a rails app.'
  spec.description = '[see summary duh]'
  spec.homepage = 'https://github.com/upserv-io/foundations'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/upserv-io/foundations'
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # tried adding this but couldn't get it to work
  # spec.add_dependency 'font-awesome-sass', '~> 6.4.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
