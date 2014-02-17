require 'cocoatree'

class PodsController < ApplicationController
  def index
    @pods = Cocoatree.pods.pods
  end
end
