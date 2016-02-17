require 'bundler/setup'

require 'appraisal'

require 'rake'
require 'rake/testtask'

desc 'Default: run unit tests.'
task default: [:clean, 'appraisal:install', :all]

desc 'Test the delayed paperclip plugin under all supported Rails versions.'
task :all do |t|
  exec('rake appraisal test spec')
end

desc 'Clean up files.'
task :clean do |t|
  FileUtils.rm_rf "doc"
  FileUtils.rm_rf "tmp"
  FileUtils.rm_rf "pkg"
  FileUtils.rm_rf "public"
  Dir.glob("paperclip-*.gem").each{|f| FileUtils.rm f }
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end
