require 'rake'

require 'yard'
require 'yard/rake/yardoc_task'
YARD::Rake::YardocTask.new do |t|
  t.files = [
    'lib/{,**/}/*.rb'
  ]
  t.options = [
    '-odoc/ruby'
  ]
end

task :doc do
  Rake::Task['yard'].invoke
end

