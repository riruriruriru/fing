class Tutorial < ApplicationRecord
	has_many :studentTutorials, dependent: :delete_all
	has_many :tutorTutorials, dependent: :delete_all
	has_many :annotations, dependent: :delete_all
	has_many :typetutorials, dependent: :delete_all

	accepts_nested_attributes_for :typetutorials
	accepts_nested_attributes_for :annotations

	
  def formatTutorialjson
  	if self.subject==1
  		colorsubject ='#f72743'
  	elsif self.subject==2
  		colorsubject ='#28a020'
  	else
  		colorsubject ='#efb61a'
  	end
  		
    {id: self.id, title: self.title, start: self.start, end: self.end, color: colorsubject, textColor: '#FFFFFF', groupid: 'tutorial',editable: false}
 end
end
