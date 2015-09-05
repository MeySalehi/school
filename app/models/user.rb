class User < ActiveRecord::Base
	has_many :classrooms, class_name: "Classroom", foreign_key: "teacher_id"
	has_secure_password
	
	has_attached_file :avatar, styles: {large: "300x300>", medium: "100x100>", thumb: "40x40>" }, default_url: "/default-avatar.gif"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
