class ExamResult < ActiveRecord::Base
	belongs_to :exam
	belongs_to :student
end
