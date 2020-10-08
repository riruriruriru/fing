class AcademicUnit < ApplicationRecord
    has_many :departments
    validates :name, presence: true,
                    length: { minimum: 5 }
end
