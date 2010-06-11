
module Papermill

  class App < Sinatra::Base
    set :haml, {:format => :html5 }
    set :logging, true
    set :public, File.dirname(__FILE__) + '/../../public'
  
    helpers do
      def display_time(time)
        time.strftime("%D %I:%M:%S %p")
      end
    end
    
    get '/?' do
      haml :index
    end
  
    get '/search' do
      @logs = Paul.search(params)
      haml :results, :layout => false
    end

    get '/stats.json' do
      content_type :json
      @stats = Paul.stats.to_json
    end
  
  end

end
