require 'cocoatree'

class PodsController < ApplicationController
  caches_page :index
  
  def index
    @pods = Cocoatree.pods.pods
  end
end
