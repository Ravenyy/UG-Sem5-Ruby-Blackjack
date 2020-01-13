require 'rake/testtask'
require 'rspec/core/rake_task'

task default: %w[test spec
 test minitest]

Rake::TestTask.new(:minitest) do |task|
 task.pattern = 'test/*_test.rb'
 test.verbose = false
 test.warning = false
end
 
RSpec::Core::RakeTask.new(:spec) do |t|
 t.pattern = Dir.glob('spec/*_test.rb')
 t.rspec_opts = '--format documentation'
 test.verbose = false
 test.warning = false

end
