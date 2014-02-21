class CocoaPod < ActiveRecord::Base
  default_scope { order('stars DESC') }

  has_and_belongs_to_many :dependencies,
                          class_name: 'CocoaPod',
                          join_table: 'cocoa_pod_dependencies',
                          association_foreign_key: :cocoa_pod_id,
                          foreign_key: :dependent_cocoa_pod_id
  
  after_initialize :init_stars
  
  def init_stars
    self.stars ||= 0
  end
  
  def serializable_hash context=nil
    h = super
    {
      'id' => id,
      'name' => name,
      'stars' => stars,
      'pushed_at' => pushed_at.try(:iso8601).to_s,
      'website_url' => website_url,
      'source_url' => source_url,
      'doc_url' => doc_url,
      'version' => version,
      'summary' => summary,
      'dependencies' => dependencies.map{|d| {'id' => d.id,
                                              'name' => d.name }}
    }
  end
end
