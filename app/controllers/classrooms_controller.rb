class ClassroomsController < ApplicationController
	before_action :confirm_logged_in
	#-------------------------------------------------
	def index
		@classrooms = Classroom.all
	end
	#-------------------------------------------------
	def show
		@classroom = Classroom.find_by(id: params[:id].to_i)

		if @classroom.blank?
			return missing_page
		end 
	end
	#-------------------------------------------------
	def edit
		@classroom = Classroom.find_by(id: params[:id].to_i)
		@teachers = User.all
		if @classroom.blank?
			return missing_page
		end
	end
	#-------------------------------------------------
	def update
		classroom = Classroom.find_by(id: params[:id].to_i)
		if !classroom.blank?
			if classroom.update(classroom_params)
				flash[:notice] = "اطلاعات با موفقیت تغییر آپدیت شد."
				return redirect_to classroom_path(classroom.id)
			else
				flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
				return redirect_to classroom_path(classroom.id)
			end
		else
			return missing_page
		end
	end
	#-------------------------------------------------
	def new
		@classroom = Classroom.new
		@teachers = User.all
		#puts "********" + @teachers.frist.first_name + "*********"
	end
	#-------------------------------------------------
	def create
		classroom = Classroom.new(classroom_params)
		if classroom.save
			return redirect_to classroom_path(classroom.id)
		else
			flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
			return redirect_to new_classroom_path
		end
	end
	#-------------------------------------------------
	def destroy
		classroom = Classroom.find_by(id: params[:id])
		if !classroom.blank?
			if classroom.destroy 
				flash[:notice] = "کلاس با موفقیت حذف شد."
				return redirect_to classrooms_path
			else
				flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
				return redirect_to classrooms_path
			end
		else
			flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
			return redirect_to classrooms_path
		end
	end
	#-------------------------------------------------
	private
		def classroom_params
			p = params.require(:classroom).permit(:name, :teacher_id, :courses_name)
			p[:teacher_id] = p[:teacher_id].to_i
			p
		end
end
