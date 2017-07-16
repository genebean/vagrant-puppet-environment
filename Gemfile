# vim:ft=ruby
source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "#{ENV['PUPPET_VERSION']}"
else
  puppetversion = '~> 5.0'
end

group :development, :unit_tests do

  gem 'json',                    '~> 2.1'
  gem 'json_pure',               '~> 2.1'
  gem 'CFPropertyList',          '~> 2.3'
  gem 'metadata-json-lint',      '~> 2.0'
  gem 'semantic_puppet',         '~> 1.0' if puppetversion =~ /4./
  gem 'rgen',                    '~> 0.8' if puppetversion =~ /4./
  gem 'puppet',                  puppetversion
  gem 'puppetlabs_spec_helper',  '~> 2.2'
  gem 'rspec-puppet',            '~> 2.6'
  gem 'yamllint',                '~> 0.0.9'

  # puppet-lint and plugins
  gem 'puppet-lint',                                      '~> 2.2'
  gem 'puppet-lint-absolute_classname-check',             '~> 0.2'
  gem 'puppet-lint-absolute_template_path',               '~> 1.0'
  gem 'puppet-lint-empty_string-check',                   '~> 0.2'
  gem 'puppet-lint-leading_zero-check',                   '~> 0.1'
  gem 'puppet-lint-resource_reference_syntax',            '~> 1.0'
  gem 'puppet-lint-spaceship_operator_without_tag-check', '~> 0.1'
  gem 'puppet-lint-trailing_newline-check',               '~> 1.1'
  gem 'puppet-lint-undef_in_function-check',              '~> 0.2'
  gem 'puppet-lint-unquoted_string-check',                '~> 0.3'
  gem 'puppet-lint-variable_contains_upcase',             '~> 1.2'
end

group :packaging do
  gem 'puppet-blacksmith',       '>= 3.3.0'
end
