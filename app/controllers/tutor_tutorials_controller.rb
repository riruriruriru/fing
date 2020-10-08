class TutorTutorialsController < ApplicationController
  
   before_action :authenticate_user!
   before_action :notification 
   before_action :readPeriod


  def show
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
    
    id= params[:id]
    @subjects = Subject.all
    tutorialname = Tutorial.where(id:id).limit(1).pluck(:subject)
        if tutorialname.empty?
           redirect_to '/404'
        else
           @tutorialinfo= Tutorial.find(params[:id])
              if @tutorialinfo.blank?
                 redirect_to '/404'
              else
                @tutorialsubject= Subject.where(id:tutorialname).limit(1).pluck(:name)
                 if @tutorialsubject.blank?
                    redirect_to '/404'
                 else
                   @tutorstutorial = TutorTutorial.where(tutorial_id:id)
                    if @tutorstutorial.blank?
                       redirect_to '/404'
                    end
                 end
              end
        end
    
 end

def update
  unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
    
  @tutortutorial = TutorTutorial.find(params[:id])
  if@tutortutorial.update(tutortutorial_params)

    @tutorstutorial = TutorTutorial.where(tutorial_id: @tutortutorial.tutorial_id)
   
     redirect_to :action=>'show', :id=> @tutortutorial.tutorial_id
   end
  end


private
  def tutortutorial_params
    params.require(:tutor_tutorial).permit(:present)
  end


end
