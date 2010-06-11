
module Papermill

  class Paul
    class << self
      def search(params = {})
        Bunyan::Logger.find(params).sort('$natural', -1).limit(100)
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
    end
  end

end
