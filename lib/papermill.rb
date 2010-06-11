
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'papermill/app'
require 'papermill/paul'
require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'config', 'bunyan.rb')

module Papermill

  def self.app
    @app ||= Rack::Builder.new do
      # use Rack::HoptoadNotifier 'mysecretkey'
      # use Rack::Session::Cookie, :key => 'rack.session', :path => '/',
      # :expire_after => 2592000, :secret => '127edea6d9bbe0568a9882462bc47432fb4692b0'
      run Papermill::App
    end
  end

end
