class PodSpecUpdater
  def update pod_spec
    cocoa_pod = CocoaPod.find_by name: pod_spec.name
    unless cocoa_pod
      cocoa_pod = CocoaPod.new name: pod_spec.name
    end
    cocoa_pod.version = pod_spec.version
    cocoa_pod.source_url = pod_spec.source_url
    cocoa_pod.summary = pod_spec.summary
    cocoa_pod.website_url = pod_spec.website_url
    cocoa_pod.doc_url = pod_spec.doc_url
    cocoa_pod.save!
  end
end
