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

  def content
    @post = Post.first(:slug => params[:slug], :post_type => params[:post_type]) or raise Error404
    Time.zone = 'Eastern Time (US & Canada)'
  end

  def e404
  end

  def feed
    options = {
            :status => "publish",
            :post_type => "post",
            :page => 1,
            :per_page => 10,
            :order => "publish_date DESC"
    }

    @posts = Post.paginate(options)

    request.format = :rss
    respond_to do |with|
      with.rss
      with.html
    end
  end

  def archives
  end

end
