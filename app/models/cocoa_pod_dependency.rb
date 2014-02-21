class CocoaPodDependency < ActiveRecord::Base
  belongs_to :cocoa_pod_id
  belongs_to :dependent_cocoa_pod_id
end
