class Error404 < StandardError; end

class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Error404, :with => :render_404

	def rescue_action_in_public(e)
	  case e when ActiveRecord::RecordNotFound
      render_404
	  else
	    super
	  end
  end

  def render_404
    respond_to do |format| 
	    format.html { render "home/e404", :status => '404 Not Found' }
	    format.xml  { render :nothing => true, :status => '404 Not Found' }
	  end
    true
  end

  private

  helper_method :logged_in?
  def logged_in?
    return !session[:user_id].blank?
  end

  helper_method :current_user
  def current_user
    Rails.logger.info "getting current user with #{session[:user_id]}"
    @current_user ||= User.first(:id => session[:user_id])
  end

  helper_method :admin?
  def admin?
    return false if not logged_in?
    current_user.user_type == "admin"
  end

  def needs_admin
    if not admin?
      Rails.logger.info current_user.inspect
      redirect_to root_url, :notice => "you can't access that ish!"
    end
    true
  end
end
