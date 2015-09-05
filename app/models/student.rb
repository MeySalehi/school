class Student < ActiveRecord::Base
	belongs_to :classroom
	has_many :exam_results
	has_many :exams, through: :classrooms
	
	has_attached_file :avatar, styles: {large: "300x300>", medium: "100x100>", thumb: "40x40>" }, default_url: "/default-avatar.gif"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
