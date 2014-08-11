
require 'rake/testtask'

task :default => :test
task :spec => :test

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/*.rb', 'test/support/*.rb']
  t.ruby_opts << '-I.'
  t.warning = true
  t.verbose = true
end
