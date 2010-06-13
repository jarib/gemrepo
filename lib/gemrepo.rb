require 'sinatra/base'
require 'rubygems/indexer'
require 'fileutils'

class GemRepo < Sinatra::Base

  disable :show_exceptions
  set :public, lambda { gemdir }

  post "/api/v1/gems" do
    if pull_spec
      save
      reindex
      "Successfully registered gem: #{@spec.name}"
    else
      error 422, "invalid gem"
    end
  end

  def pull_spec
    format = Gem::Format.from_io request.body
    @spec = format.spec
  rescue Exception => ex
    puts ex.message
    false
  end

  def save
    path = "#{gem_repository}/#{@spec.original_name}.gem"
    File.open(path, "wb") { |io|
      io << request.body.string
    }
  end

  def reindex
    indexer.generate_index
  end

  def gem_repository
    @gem_repository ||= (
      dir = File.join(settings.gemdir, "gems")
      FileUtils.mkdir_p(dir) unless File.directory?(dir)

      dir
    )
  end

  def indexer
    @indexer = Gem::Indexer.new settings.gemdir
  end
end


