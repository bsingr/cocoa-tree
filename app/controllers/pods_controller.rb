class PodsController < ApplicationController
  caches_page :index
  
  def index
    @pods = CocoaPod.all
    @pods.keep_if{|p| p.name =~ /#{params[:filter]}/}
  end
end
