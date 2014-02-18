class PodsController < ApplicationController
  caches_page :index
  
  def index
    pods = Cocoatree.pods
    @pods = pods.source.pods[0..50]\
      .map { |p| pods.pod(p) }\
      .compact\
      .keep_if(&:github?)
  end
end
