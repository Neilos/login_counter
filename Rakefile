require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |s|
  s.rspec_opts = ['-cfs --backtrace']
end

task :default => :spec