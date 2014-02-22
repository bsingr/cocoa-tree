class DeploysController < ApplicationController
  def clear
    Rails.cache.clear
    render :text => :ok
  end
  
  def index
    render :text => :download
  end
end
