require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

namespace :rm do
  desc 'Remove ./log files'
  task :log do
    FileUtils.rm_rf('log')
  end
end

desc 'Run style check, tests and build'
task full_build: [:'rm:log', :rubocop, :spec, :build]
