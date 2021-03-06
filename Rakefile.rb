require "bundler/gem_tasks"
require 'rspec'
#require './rake_helper/spec.rb'

task :package => :build

def gems
  ['frazzle', 'cxxproject', 'cxx', 'cxxproject_gcctoolchain', 'cxxproject_progress']
end

desc 'prepare acceptance tests'
task :prepare_accept do
  gems.each do |gem|
    cd "../#{gem}" do
      sh 'rm -rf pkg'
      sh 'rake package'
    end
  end
  gems.each do |gem|
    sh "gem install ../#{gem}/pkg/*.gem"
  end
end

require 'rspec/core/rake_task'

desc 'run acceptance tests'
RSpec::Core::RakeTask.new(:accept) do |t|
  t.pattern = 'accept/**/*_spec.rb'
  if ENV['BUILD_SERVER']
    t.rspec_opts = '-r ./junit.rb -f JUnit -o build/test_details.xml'
  end
end

desc 'run specs tests'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  if ENV['BUILD_SERVER']
    t.rspec_opts = '-r ./junit.rb -f JUnit -o build/test_details.xml'
  end
end
