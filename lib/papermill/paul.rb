
module Papermill

  class Paul
    INTEGER_SEARCH_FIELDS = ['status']

    class << self
      def search(params = {})
        Bunyan::Logger.find(format_params(params), :limit => 100, :sort => ['$natural', -1])
      end

      def stats(opts = {})
        opts[:limit] ||= 10

        map = "function() {
          if (!this.controller_action) {
            return false;
          }
          
          emit(this.controller_action, { count: 1 });
        }"
        
        reduce = "function(key, values) {
          var sum = 0;
          values.forEach(function(doc) {
            sum += doc.count;
          });
          
          return { count: sum };
        }"
        results = Bunyan::Logger.collection.map_reduce map, reduce
        results.find({}, :limit => opts[:limit], :sort => ['value.count', :descending]).to_a
      end

      private
        def format_params(params)
          @query_params = {}
          params['search-fields'].each_with_index do |item, index|
            @query_params[item] = build_query_for_field(item, params['search-values'][index])
          end unless params.empty?
          @query_params
        end
          
        def build_query_for_field(key, value)
          exact_search_field?(key) ? value.to_i : /#{value}/
        end
  
        def exact_search_field?(field)
          INTEGER_SEARCH_FIELDS.include? field
        end
    end

  end

end
