class UpdateCocoaPodFromPodSpecJob
  def run
    pod_spec_updater = PodSpecUpdater.new
    pod_spec_decorator = PodSpecDecorator.new
    pod_spec_index = PodSpecIndex.new
    pod_spec_index.pod_specs.each do |pod_spec|
      pod_spec_decorator.pod_spec = pod_spec
      pod_spec_updater.update pod_spec_decorator
    end
  end
end
