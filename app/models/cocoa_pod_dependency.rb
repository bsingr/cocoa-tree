class CocoaPodDependency < ActiveRecord::Base
  belongs_to :cocoa_pod
  belongs_to :dependent_cocoa_pod, class_name: 'CocoaPod'
end
