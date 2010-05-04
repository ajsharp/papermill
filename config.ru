# Use locked gems if present.
begin
  require File.expand_path('.bundle/environment', __FILE__)

rescue LoadError
  require 'rubygems'
  require 'bundler'
  Bundler.setup
end

Bundler.require :default, ENV['RACK_ENV']

require 'app'
run Papermill
