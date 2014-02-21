class PodSpecDependencyUpdater
  def update pod_spec
    if cocoa_pod = CocoaPod.find_by(name: pod_spec.name)
      pod_spec.dependencies.each do |d|
        if dependency = CocoaPod.find_by(name: d)
          CocoaPodDependency.create! dependent_cocoa_pod: cocoa_pod,
                                     cocoa_pod: dependency
        end
      end
    end
  end
end
