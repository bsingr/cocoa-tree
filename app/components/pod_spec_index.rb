class PodSpecIndex
  attr_reader :source

  def initialize
    self.source_path = File.join(Rails.root, 'Specs')
  end
  
  def source_path=source_path
    @source = ::Pod::Source.new(source_path)
  end
  
  def pod_spec name
    if spec_set = source.set(name)
      spec_set.specification
    end
  rescue ::Pod::DSLError => e
    nil
  end
  
  def pod_specs
    source.pods.map{ |p| pod_spec(p) }.compact
  end
end