require File.join(File.expand_path(File.dirname(__FILE__)), 'config', 'bunyan.rb')

class Papermill < Sinatra::Base
  INTEGER_SEARCH_FIELDS = ['status']
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
      @query_params[item] = build_query_for_field(item, params['search-values'][index])
    end unless params.empty?
    @query_params
  end

  get '/?' do
    haml :index
  end

  get '/search' do
    @logs = Bunyan::Logger.find(@query_params).sort('$natural', -1).limit(100)
    haml :results, :layout => false
  end

  protected
    def build_query_for_field(key, value)
      exact_search_field?(key) ? value.to_i : /#{value}/
    end

    def exact_search_field?(field)
      INTEGER_SEARCH_FIELDS.include? field
    end
end

