class StudentTutorialsController < ApplicationController
  before_action :authenticate_user!
  before_action :notification 
  before_action :readPeriod


  # GET /student_tutorials
  # GET /student_tutorials.json
  def index
    redirect_to '/404'
  end

  def show
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
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
                  @studentstutorial = StudentTutorial.where(tutorial_id:id)
                    if @studentstutorial.blank?
                       redirect_to '/404'
                    else
                     numberoftrue = @studentstutorial.where(:present => true).count
                     numberoffalse = @studentstutorial.where(:present => false).count
                     total= numberoffalse+numberoftrue

                   # @percent= (numberoftrue*100)/total
                   #getPercent
                    end
                 end
              end
        end
    
 end

   

    



  def edit
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end 

  @studentttutorial = StudentTutorial.find(params[:id])
  end

  def update
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end 
    
  @studenttutorial = StudentTutorial.find(params[:id])
  if@studenttutorial.update(studenttutorial_params)

   end
  end

  def getPercent

    @studentstutorial = StudentTutorial.where(tutorial_id: params[:id])
    numberoftrue = @studentstutorial.where(:present => true).count
    numberoffalse = @studentstutorial.where(:present => false).count
    total= numberoffalse+numberoftrue
    @percent= (numberoftrue*100)/total

      render json: {
        success: true,
        response: "Porcentaje de asistencia: #{@percent}%"
      }
  end

 
private
  def studenttutorial_params
    params.require(:student_tutorial).permit(:present)
  end

  


end
