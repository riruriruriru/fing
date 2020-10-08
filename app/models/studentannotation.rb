class Studentannotation < ApplicationRecord
  belongs_to :statusannotation
  belongs_to :typeannotation
  belongs_to :user
  belongs_to :student

end
