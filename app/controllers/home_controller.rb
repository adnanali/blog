class HomeController < ApplicationController
  def index
    params[:page] = 1 if (params[:page].blank?)
    options = {
            :status => "publish",
            :page => params[:page],
            :per_page => 10,
            :order => "publish_date DESC"
            }
    options[:categories] = params[:category] if (not params[:category].blank?)

    @posts = Post.paginate(options)
    #@posts = Post.all
  end

end
