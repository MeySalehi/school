class AuthenticateController < ApplicationController
	before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
	layout false, except: ["dashboard"]
	
	def login	
	end

	def attempt_login
		if params[:login][:email].present? && params[:login][:password].present?
			
			found_user = User.where(:email => params[:login][:email]).first

			if found_user
				authorized_user = found_user.authenticate(params[:login][:password])
			end
		end
		if authorized_user
			# mark user as logged in
			full_name = authorized_user.first_name + " " + authorized_user.last_name
			session[:user_id]		= authorized_user.id
			session[:email]	= authorized_user.email
			session[:full_name]	= full_name
			session[:access_level] = authorized_user.access_level
			session[:avatar] = authorized_user.avatar(style: "thumb")
			flash[:notice] = "خوش آمدید #{full_name}."
			redirect_to root_path
		else
			flash[:error] = "ایمیل یا رمز عبور وارد شده صحیح نیست!"
			redirect_to login_path, status: 200
		end
	end
	# ---------------------------------------------------
	def logout
		# mark user as logged out
		session[:user_id]		= nil
		session[:email]	= nil
		session[:full_name]	= nil
		session[:access_level] = nil
		session[:avatar] = nil

		redirect_to login_path, status: 200
	end
	def dashboard
		@user = User.find(session[:user_id].to_i)
	end
	# ---------------------------------------------------
	
	# def reset_password

	# end

	
end
