
Bunyan::Logger.configure do |config|
  config.database    'optimis_bunyan_logger'
  config.collection  'development_log'
end

class Papermill < Sinatra::Base
  set :haml, {:format => :html5 }
  set :logging, true
  set :public, File.dirname(__FILE__) + '/public'

  helpers do
    def display_time(time)
      time.strftime("%D %I:%M:%S %p")
    end
  end
  
  before do
    @query_params = {}
    params['search-fields'].each_with_index do |item, index|
      @query_params[item] = /#{params['search-values'][index]}/
    end unless params.empty?
    @query_params
  end

  get '/?' do
    haml :index
  end

  get '/search' do
    @logs = Bunyan::Logger.find(@query_params)
    haml :results, :layout => false
  end
end

