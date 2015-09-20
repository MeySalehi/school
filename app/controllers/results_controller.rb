class ResultsController < ApplicationController
	before_action :confirm_logged_in
	#-------------------------------------------------
	def index
		@exams = Classroom.find_by(id: params[:classroom_id].to_i).exams
		#json = "[\"نوبت دوم\",\"میان ترم دوم\",\"نوبت اول\",\"میانترم اول\"]"
		#set by options
		@exam_titles = ['نوبت اول','نوبت دوم']

	end
	#-------------------------------------------------
	def show
		@result = ExamResult.find_by(id: params[:id].to_i)
		if @result.blank?
			return missing_page
		end
	end
	#-------------------------------------------------
	def edit
		@result = ExamResult.find_by(id: params[:id].to_i)
		if @result.blank?
			return missing_page
		end
	end
	#-------------------------------------------------
	def update
		@result = ExamResult.find_by(id: params[:id].to_i)
		if !@result.blank?
			if @result.update(result_params)
				flash[:notice] = "اطلاعات با موفقیت بروزرسانی شد."
				return redirect_to
								classroom_student_result_path(classroom_id: params[:classroom_id],
																								student_id: params[:student_id],
																									id: params[:id])
			else
				flash[:error] = "خطایی رخ داده است، لطفا دوباره امتحان کنید یا با پشتیبان تماس بگیرید."
				return redirect_to
								classroom_student_result_path(classroom_id: params[:classroom_id],
																								student_id: params[:student_id],
																									id: params[:id])
			end
		else
			return missing_page
		end
	end
	#-------------------------------------------------
	def export
		@exams = Classroom.find_by(id: params[:classroom_id].to_i).exams
		#json = "[\"نوبت دوم\",\"میان ترم دوم\",\"نوبت اول\",\"میانترم اول\"]"
		#set by options
		@exam_titles = ['نوبت اول','نوبت دوم']
	end
	#-------------------------------------------------
	private
		def result_params
			p = require(:result).permit(:result, :description)
			p[:result] = p[:result].to_i
			p
		end
end
