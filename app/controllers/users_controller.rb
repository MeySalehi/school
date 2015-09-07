class UsersController < ApplicationController
	before_action :confirm_logged_in
	#-------------------------------------------------
	def index
		@users = User.all
	end
	#-------------------------------------------------
	def show
		@user = User.find_by(id: params[:id].to_i)
		if @user.blank?
			return missing_page
		end
	end
	#-------------------------------------------------	
	def edit
		@user = User.find_by(id: params[:id].to_i)
		if @user.blank?
			return missing_page
		end
	end
	#-------------------------------------------------
	def update
		user = User.find_by(id: params[:id].to_i)
		if !user.blank?
			if user.update(user_params)
				flash[:notice] = "اطلاعات با موفقیت تغییر آپدیت شد."
				return redirect_to user_path(user.id)
			else
				flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
				return redirect_to user_path(user.id)
			end
		else
			return missing_page
		end
	end
	#-------------------------------------------------
	def new
		@user = User.new
	end
	#-------------------------------------------------
	def create
		user = User.new(user_params)
		if user.save
			return redirect_to user_path(user.id)
		else
			flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
			return redirect_to new_user_path
		end
	end
	#-------------------------------------------------
	def destroy
		user = User.find_by(id: params[:id])
		if !user.blank?
			if user.destroy 
				flash[:notice] = "کاربر با موفقیت حذف شد."
				return redirect_to users_path
			else
				flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
				return redirect_to users_path
			end
		else
			flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
			return redirect_to users_path
		end
	end
	#-------------------------------------------------
	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :avatar, :bio, :access_level)
		end
end
