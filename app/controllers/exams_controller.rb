class ExamsController < ApplicationController
	before_action :confirm_logged_in
	#-------------------------------------------------
	def index
		if params[:classroom_id] != nil
			@exams = Exam.find_by(id: params[:classroom_id].to_i)
			if @exams.blank?
				return missing_page
			end
		else
			@classrooms = Classroom.all
		end
	end
	#-------------------------------------------------
	def show
		@exam = Exam.find_by(id: params[:id].to_i)
		if !@exam.blank?
			@results = @exam.exam_results
		else
			return missing_page
		end
	end
	#-------------------------------------------------
	def edit
		@exam = Exam.find_by(id: params[:id])
		if !@exam.blank?
			@results = @exam.exam_results
		else
			return missing_page
		end
	end
	#-------------------------------------------------
	def update
		exam = Exam.find_by(id: params[:id])
		if !@exam.blank?
			if @exam.update(exam_params)
				flash[:notice] = "اطلاعات با موفقیت بروزرسانی شد."
				return redirect_to classroom_exam_path(classroom_id: params[:classroom_id], id: @exam.id)
			else
				flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
				return redirect_to classroom_exam_path(classroom_id: params[:classroom_id], id: @exam.id)
			end
		else
			return redirect_to classroom_exams_path(params[:classroom_id])
		end
	end
	#-------------------------------------------------
	def new
		@classroom = Classroom.find_by(id: params[:classroom_id])
		@students = Student.where(classroom_id: params[:classroom_id])
		if !@classroom.blank?
			@exam = Exam.new
			@students.count.times {@exam.exam_results.build}
		else
			return missing_page
		end
	end
	#-------------------------------------------------
	def create
		@exam_params = new_results_params

		if new_exam = Exam.create!(new_results_params)
			return redirect_to classroom_exam_path(classroom_id: new_exam.classroom.id, id: new_exam.id)
		else
			return redirect_to new_classroom_exam_path(classroom_id: new_exam.classroom.id)
		end
	end
	#-------------------------------------------------
	def destroy
		@exam = Exam.find_by(id: params[:exam][:id])
		if !@exam.blank?
			@exam.exam_results.destroy_all
			@exam.destroy
			flash[:notice] = "امتحان با موفقیت حذف شد."
			return redirect_to classroom_exams_path(params[:classroom_id])
		else
			flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
			return redirect_to classroom_exam_path(classroom_id: params[:classroom_id], id: params[:id])
		end
	end
	#-------------------------------------------------
	private
		def exam_params
			p = require(:exam).permit(:title, :exam_date, :score_range, :course_name, :description, :classroom_id)
			p[:classroom_id] = p[:classroom_id].to_i
			p
		end
		def new_results_params
			params.require(:exam).permit(:title, :exam_date, :score_range, :course_name, :description, :classroom_id,
																	exam_results_aattributes: [:exam_id, :student_id, :result, :description])
		end
end
