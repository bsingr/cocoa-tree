class UpdateCocoaPodFromPodSpecJob
  def run
    Cocoatree.pods.pods.each do |pod|
      cocoa_pod = CocoaPod.find_by name: pod.name
      unless cocoa_pod
        cocoa_pod = CocoaPod.new name: pod.name
      end
      cocoa_pod.version = pod.version
      cocoa_pod.save!
    end
  end
end
