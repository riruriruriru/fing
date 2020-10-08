class Tutor < ApplicationRecord
	has_many :tutorTutorial, dependent: :nullify
	belongs_to :department
	def name; "#{firstname} #{lastname} #{lastnamema}";end
end
