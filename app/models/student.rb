class Student < ApplicationRecord
	has_many :studentTutorials, dependent: :nullify
	has_many :studentannotations , dependent: :destroy

	accepts_nested_attributes_for :studentannotations
	belongs_to :department
	def name; "#{firstname} #{lastname} ";end
end
