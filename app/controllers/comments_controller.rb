class CommentsController < ApplicationController
  layout "admin"
  before_filter :needs_admin, :except => [:create]
  # GET /comments
  # GET /comments.xml
  def index
    params[:page] = 1 if (params[:page].blank?)
    options = {
            :page => params[:page],
            :per_page => 30,
            :order => "updated_at DESC"
            }
    options[:approved] = params[:approved] if (not params[:approved].blank?)

    @comments = Comment.paginate(options)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
#  def show
#    @comment = Comment.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @comment }
#    end
#  end

  # GET /comments/new
  # GET /comments/new.xml
#  def new
#    @comment = Comment.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @comment }
#    end
#  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @post = Post.find(params[:comment][:post_id]) 
    @comment = Comment.new(params[:comment])
    @comment.request = request
    #@comment.post = post

    respond_to do |format|
      if @comment.save
        format.js { render :text => @comment.id }
      else
        format.js { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    params[:comment][:categories] = params[:comment][:categories].split(",")
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

  def list
    @post = Post.find(params[:post_id])
    @comments = @post.approved_comments
  end
end
