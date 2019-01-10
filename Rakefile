require 'rubygems'
require 'puppet_blacksmith/rake_tasks'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'yamllint/rake_task'

exclude_paths = [
  "vendor/**/*",
]

PuppetLint::RakeTask.new :lint do |config|
  config.fail_on_warnings = true
  config.ignore_paths = exclude_paths
  config.log_format = "%{path}:%{line}:%{check}:%{KIND}:%{message}"
end

PuppetSyntax.exclude_paths = exclude_paths

desc "Validate manifests"
task :validate do
  Dir['scripts/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
end

YamlLint::RakeTask.new do |yamllint|
  yamllint.paths = %w(
    *.yml
    facts.d/*.yml
    facts.d/*.yaml
  )
end

task :tests do
  Rake::Task[:lint].invoke
  Rake::Task[:validate].invoke
  Rake::Task[:yamllint].invoke
  Rake::Task[:spec].invoke
end
