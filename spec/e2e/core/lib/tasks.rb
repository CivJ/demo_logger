#!/usr/bin/env rake
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

desc 'Run RuboCop on lib and spec directories, Gemfile, gemspec, Rakefile; Override with a space delimited list'
RuboCop::RakeTask.new(:rubocop, :pattern) do |task, args|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb', 'Gemfile', '*.gemspec', 'Rakefile']
  task.patterns = args[:pattern].split(' ') if args[:pattern] # override default pattern
  # don't abort rake on failure
  task.fail_on_error = false
end

namespace :spec do
  RSpec::Core::RakeTask.new(:unit) do |task|
    task.pattern = 'spec/**/*_spec.rb'
  end
end
