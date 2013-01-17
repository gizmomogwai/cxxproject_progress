cxx_plugin do
  $stderr.puts "progress plugin"
  require 'cxxproject_progress/rake_listener' # monkey
  require 'cxxproject_progress/progressbar' # monkey

  require 'cxxproject_progress/progress_helper'
  require 'cxxproject_progress/progress'
  require 'cxxproject_progress/version'
end
