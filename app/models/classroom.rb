class Classroom < ActiveRecord::Base
	belongs_to :teacher, class_name: "User"
	has_many :exams
	has_many :students
	
	has_many :exam_results, through: :exams
end
