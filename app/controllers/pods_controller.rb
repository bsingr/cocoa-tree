class PodsController < ApplicationController
  caches_page :index, :show
  
  def index
    @pods = CocoaPod.all
    pods_index = CocoaPod.all.each_slice(100).each_with_index.map do |pods, index|
      [index, pods.map(&:name)]
    end
    gon.push(pods_index: pods_index)
  end

  def show
    data = CocoaPod.all.each_slice(100).to_a
    @pods = data[params[:id].to_i]
    respond_to do |format|
      format.mpac { render :text => MessagePack.dump(@pods.map(&:serializable_hash)) }
      format.json { render json: @pods }
      format.html
    end
  end
end
