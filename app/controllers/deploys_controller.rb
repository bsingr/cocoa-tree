class DeploysController < ApplicationController
  def clear
    Rails.cache.clear
    render :text => :ok
  end
  
  def index
    system 'tar -cf public.tar public/'
    send_file File.new('public.tar')
  end
end
