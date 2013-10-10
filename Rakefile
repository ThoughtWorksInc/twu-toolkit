require 'rake/testtask'

Rake::TestTask.new(:unit) do |t|
  t.libs << "test"
  t.libs << "src"
  t.verbose = true
end

task :default => :unit
