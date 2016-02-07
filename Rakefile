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

  desc 'Remove ./email files'
  task :email do
    FileUtils.rm_rf('email')
  end
end

desc 'Run style check, tests and build'
task full_build: [:'rm:log', :'rm:email', :rubocop, :spec, :build]
