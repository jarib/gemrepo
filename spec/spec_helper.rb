$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'gemrepo'
require 'spec'
require 'spec/autorun'
require 'rack/test'
require 'yaml'
require 'pp'

module GemRepoHelper
  def app
    GemRepo
  end

  def gemdir
    File.join(File.dirname(__FILE__), 'tmp')
  end

  def clear_gemdir
    FileUtils.rm_rf(gemdir)
  end

  def current_gems
    Dir["#{gemdir}/gems/*.gem"]
  end

  def sample_gem
    File.open(sample_gem_path, "rb") do |io|
      return io.read
    end
  end

  def sample_gem_path
    File.join(File.dirname(__FILE__), 'sample-0.0.1.gem')
  end

  def current_index
    file = "#{gemdir}/yaml"
    YAML.load_file(file) if File.exist? file
  end

  def create_index
    dir = "#{gemdir}/gems"

    FileUtils.mkdir_p dir
    FileUtils.cp sample_gem_path, dir
    Gem::Indexer.new(gemdir).generate_index
  end
end


Spec::Runner.configure do |config|
  config.include Rack::Test::Methods
  config.include GemRepoHelper
end


