class StudentsController < ApplicationController
	before_action :confirm_logged_in
	#-------------------------------------------------
	def index
		if params[:classroom_id] == nil
			@students = Student.all
		else
			@students = Student.where(classroom_id: params[:classroom_id].to_i)

		end
	end
	#-------------------------------------------------
	def show
		@student = Student.find_by(id: params[:id].to_i)
		@teacher = @student.classroom.teacher
		@teacher_name = @teacher.first_name + " " + @teacher.last_name
		if @student.blank?
			if params[:classroom_id].to_i <= 0
				return redirect_to students_path
			else
				return redirect_to classroom_students_path(params[:classroom_id])
			end
		end
	end
	#-------------------------------------------------
	def edit
		@student = Student.find_by(params[:id].to_i)
		if @student.blank?
			return missing_page
		else
			@classroom = Classroom.find_by(id: params[:classroom_id].to_i)
			if @classroom.blank?
				@classrooms = Classroom.all
			end
		end
	end
	#-------------------------------------------------
	def update
		student = Student.find_by(id: params[:id].to_i)
		if !student.blank?
			if student.update(student_params)
				flash[:notice] = "اطلاعات با موفقیت بروزرسانی شد."
				return redirect_to student_path(student.id)
			else
				flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
				return redirect_to student_path(student.id)
			end
		else
			return missing_page
		end
	end
	#-------------------------------------------------
	def new
		@student = Student.new
		@classroom = Classroom.find_by(id: params[:classroom_id].to_i)
		if @classroom.blank?
			@classrooms = Classroom.all
		end
	end
	#-------------------------------------------------
	def create
		student = Student.new(student_params)
		if student.save
			return redirect_to student_path(student.id)
		else
			flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
			return redirect_to new_student_path
		end
	end
	#-------------------------------------------------
	def destroy
		student = Student.find_by(id: params[:id])
		if !student.blank?
			if student.destroy 
				flash[:notice] = "دانش‌آموز با موفقیت حذف شد."
				return redirect_to students_path
			else
				flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
				return redirect_to students_path
			end
		else
			flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
			return redirect_to students_path
		end
	end
	#-------------------------------------------------
	private
		def student_params
			p = params.require(:student).permit(:classroom_id, :first_name, :last_name, :middle_name, :id_number, :birth_date, :address, :phone, :description, :avatar)
			p[:classroom_id] = p[:classroom_id].to_i
			p
		end
end
