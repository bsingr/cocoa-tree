class DeploysController < ApplicationController
  def clear
    ActionController::Base::expire_page '/'
    system 'rm -rf public/pods'
    head :ok
  end
  
  def index
    system 'tar -cf public.tar public/'
    send_file File.new('public.tar')
  end
end
