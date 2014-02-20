class PodSpecDecorator
  attr_accessor :pod_spec
  
  def name
    pod_spec.name
  end
  
  def version
    pod_spec.version
  end
  
  def website_url
    pod_spec.homepage
  end
  
  def source_url
    pod_spec.source[:git]
  end
  
  def doc_url
    "http://cocoadocs.org/docsets/#{name}/#{version}"
  end
end
