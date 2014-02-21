class PodsController < ApplicationController
  caches_page :index, :show
  
  def index
    @pods = CocoaPod.all
    @data = CocoaPod.all.each_slice(100).each_with_index.map do |pods, index|
      [index, pods.map(&:name)]
    end
    respond_to do |format|
      format.mpac { render :text => MessagePack.dump(@data) }
      format.json { render json: @data }
      format.html
    end
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
