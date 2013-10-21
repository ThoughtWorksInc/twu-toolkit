require 'rake/testtask'

Rake::TestTask.new(:unit) do |t|
  t.libs << "test/unit"
  t.libs << "src"
  t.pattern = "test/unit/test*.rb"
  t.verbose = true
end

task :default => :unit


