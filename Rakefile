require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "gemrepo"
    gem.summary = %Q{A simple gem server, useful for internal gem repos}
    gem.description = %Q{A simple gem server that supports gem push / install.}
    gem.email = "jari.bakken@gmail.com"
    gem.homepage = "http://github.com/jarib/gemrepo"
    gem.authors = ["Jari Bakken"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "rack-test", ">= 0.5.3"
    gem.add_dependency "sinatra", ">= 1.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

