require 'yaml'

module Cocoatree
  class Cache
    attr_reader :path

    def initialize filename
      @path = File.join(Cocoatree.root, filename + '.yml')
      reload
    end

    def fetch item_id, item_attr_name
      data = read

      # try to read cache
      if item = data[item_id]
        if item['expires_at'] > Time.now
          if item_data = item['data']
            if item_attr_value = item_data[item_attr_name]
              puts "READ CACHE #{item_id}"
              return item_attr_value
            end
          end
        end
      end

      item_data = yield

      # fetch + update cache
      puts "CACHE UPDATE #{item_id}"
      data[item_id] ||= {}
      data[item_id]['expires_at'] = Time.now + 14*60*60*24 # 14 days
      data[item_id]['data'] = item_data
      
      write! data
      return item_data[item_attr_name]
    end

    def reload
      @memory_cache = nil
    end

  private

    def read
      if @memory_cache
        @memory_cache
      else
        hash = YAML.load_file(path)
        @memory_cache = hash.is_a?(Hash) ? hash : {}
      end
    rescue => e
      return {}
    end

    def write! data
      @memory_cache = data
      File.open(path, 'w') {|f| f.puts YAML.dump(data)}
    end
  end
end
