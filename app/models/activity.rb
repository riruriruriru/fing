class Activity < ApplicationRecord

def formatjson
    {id: self.id, title: self.title, start: self.start, end: self.end, color: self.color, groupid: self.groupId,textColor: '#FFFFFF',description: self.description}
 end


	
end
