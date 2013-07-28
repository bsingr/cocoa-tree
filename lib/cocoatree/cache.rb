require 'yaml'

module Cocoatree
  class Cache
    attr_reader :path

    def initialize filename, logger=nil
      @logger = logger
      @path = File.join(Cocoatree.root, filename + '.yml')
      reload
    end

    def get key
      data = read

      if entry = data[key]
        if entry['expires_at'] > Time.now
          log "READ CACHE #{key}"
          return entry['value']
        end
      end
    end

    def set key, value
      data = read

      log "CACHE UPDATE #{key}"
      data[key] ||= {}
      data[key]['expires_at'] = Time.now + 14*60*60*24 # 14 days
      data[key]['value'] = value
      write! data

      true
    end

    def fetch key
      # try to get cache
      if value = get(key)
        return value
      end

      # set
      value = yield
      set key, value

      # get
      return value
    end

    def reload
      @memory_cache = nil
    end

  private

    def log msg
      @logger.info msg if @logger
    end

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
