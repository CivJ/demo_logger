require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

namespace :rm do
  desc 'Remove ./tmp files'
  task :tmp do
    FileUtils.rm_rf('tmp')
  end
end

desc 'Run style check, tests and build'
task full_build: [:'rm:tmp', :rubocop, :spec, :build]
