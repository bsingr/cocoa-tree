class CocoaPod < ActiveRecord::Base
  class ActiveSupport::TimeWithZone
    def to_msgpack context=nil
      to_s
    end
  end

  default_scope { order('stars DESC') }
  
  after_initialize :init_stars
  
  def init_stars
    self.stars ||= 0
  end
  
  def dependencies
    []
  end
  
  def serializable_hash context=nil
    h = super
    {
      'name' => name,
      'stars' => stars,
      'pushed_at' => pushed_at.try(:iso8601).to_s,
      'website_url' => website_url,
      'source_url' => source_url,
      'doc_url' => doc_url,
      'version' => version
    }
  end
end
