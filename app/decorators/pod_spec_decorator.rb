class PodSpecDecorator
  attr_accessor :pod_spec
  
  def name
    pod_spec.name
  end
  
  def version
    pod_spec.version.to_s
  end
  
  def summary
    pod_spec.summary
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
  
  def github
    GithubUrl.new.shortcut(source_url)
  end

  def dependencies
    pod_spec.dependencies
  end
end
