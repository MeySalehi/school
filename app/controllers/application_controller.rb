class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def confirm_logged_in
  	unless session[:user_id]
  		redirect_to(login_path)
  		return false
  	else
  		return true
  	end
  end
  def missing_page
		 render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404 and return
	end
end
