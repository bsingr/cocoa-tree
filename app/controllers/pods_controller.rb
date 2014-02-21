class PodsController < ApplicationController
  caches_page :index
  
  def index
    @pods = CocoaPod.all
    @pods.keep_if{|p| p.name =~ /#{params[:filter]}/}
    respond_to do |format|
      #format.mpac { render :text => MessagePack.dump(@pods[0].map{|p| p.serializable_hash}) }
      format.mpac { render :text => MessagePack.dump(@pods.map(&:serializable_hash)) }
      format.json { render json: @pods }
      format.html
    end
  end
end
