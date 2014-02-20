class CocoaPod < ActiveRecord::Base
  after_initialize :init_stars
  
  def init_stars
    self.stars ||= 0
  end
  
  def dependencies
    []
  end
end
