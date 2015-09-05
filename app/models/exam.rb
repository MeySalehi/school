class Exam < ActiveRecord::Base
	has_many :exam_results
	belongs_to :classroom
	has_many :students, through: :classroom
	
	accepts_nested_attributes_for :exam_results
end
