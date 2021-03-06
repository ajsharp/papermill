require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require :default, :test

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
require 'lib/papermill'

require 'spec'
require 'rack/test'

set :environment, :test

Spec::Runner.configure do |conf|
  conf.include Rack::Test::Methods

  def app
    Papermill::App
  end
end

