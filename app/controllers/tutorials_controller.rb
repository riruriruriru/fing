class TutorialsController < ApplicationController
  before_action :authenticate_user!
  before_action :notification
  before_action :readPeriod
    before_action :readCareer
  

  def index
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
    
    @tutorials = Tutorial.where('extract(year  from dates) = ?', @period).order("dates DESC")
     @tutors = Tutor.where(status:true)
     tutorials = Tutorial.all
    @tutorials.order(dates: :desc)
	@careers = Career.all
    @codes=[]
    count=0
    @careers.each do |c|
        if c.id == @carreers4department[count]
            @codes<< c.code
           count=count+1
         end
         
    end    
    @subjects = Subject.all
    respond_to do |format|
        format.html
        format.json { render :json => tutorials }
    end
   
    
  end


  def show
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    idd = params[:id]
    @tutorial = Tutorial.find_by(id: params[:id])
    @comments = Annotation.where(tutorial_id:idd)
      @timenow= Time.now
      @time45minutes= @timenow+45.minutes
        types = Typetutorial.where(tutorial_id: idd)
        typenames = Type.all

        @tipos=[]

        types.each do |type|
          typenames.each do |typename|
            if type.type_id == typename.id
               @tipos << typename.name
            end
          end
        end
            if @tipos.empty?
              @tutorial.typetutorials.build
            end

        


    
    

    if @tutorial.timestart.blank?
      @duracion = ((@time45minutes - @timenow) / 1.minutes).to_i
    else
      @duracion = ((@tutorial.timeend - @tutorial.timestart)/ 1.minutes).to_i
    end



    if @tutorial.blank?
      redirect_to '/404'
    end
   
     
  end


  def new
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

     @tutorial = Tutorial.new
     @tutorial.typetutorials.build
     @tutorial.annotations.build

     
     
  end




def create
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    if params[:tutorial][:tutores].blank?
       flash[:noticen] = "Error al guardar, no se seleccionó tutor" 
      redirect_to request.referrer

    else

    @tutorial = Tutorial.new(tutorial_params)
   

    @types=@tutorial.typetutorials.build(type_id: params[:tutorial][:type_id], tutorial_id:@tutorial.id)
    

    @tutors = params[:tutorial][:tutores].drop(1)
    @students= Student.where(status:true).where(entry: @period)
    
    
     subjects= Subject.all

     subjects.each do |subject| 
      if @tutorial.subject== subject.id
        @tutorial.title='Tutoría '+subject.name
      end
     end
  @tutorial.start=@tutorial.dates
  @tutorial.end=@tutorial.dates

   if @students.blank?
    flash[:noticen] = "Error al guardar, no hay estudiantes registrados. " 
      render 'new'
   else
    if @tutorial.save
      @careers = Career.all
    @codes=[]
    count=0
    @careers.each do |c|
        if c.id == @carreers4department[count]
            @codes<< c.code
           count=count+1
         end
         
    end

    @students = Student.where(status:true).where(entry: @period).where(careercode: @codes[0])
    .or(Student.where(status:true).where(entry: @period).where(careercode: @codes[1]))
    .or(Student.where(status:true).where(entry: @period).where(careercode: @codes[2]))
    .or(Student.where(status:true).where(entry: @period).where(careercode: @codes[3]))
    
      
       
        @students.each do |student|
           @studenttutorials= StudentTutorial.new(present:false, student_id:student.id,tutorial_id:@tutorial.id)
           @studenttutorials.save
        end

        if @tutors.count >=2
            @tutors.each do |tutor|
              @tutortutorials= TutorTutorial.new(present:false, tutor_id:tutor.to_i, tutorial_id:@tutorial.id)
              @tutortutorials.save
            end
        else
            @tutors.each do |tutor|
              @tutortutorials= TutorTutorial.new(present:false, tutor_id:tutor.to_i, tutorial_id:@tutorial.id)
              @tutortutorials.save
            end
         end
        
       redirect_to request.referrer
       flash[:noticep] = "Tutoría creada con éxito. "
    else
      flash[:noticen] = "Error al guardar. " 
      redirect_to request.referrer
    end
   end
      
    end
      
end


  def edit
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

  @tutorial = Tutorial.find(params[:id])
  @tutorial.typetutorials.build

 
  end

  def update
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
 
  @tutorial = Tutorial.find(params[:id])


  if @tutorial.update_attributes(tutorial_params)

    redirect_to request.referrer
  else
    flash[:noticen] = "Error al actualizar. " 
  end
 
  end
 

  # DELETE /tutorials/1
  # DELETE /tutorials/1.json
  def destroy
    unless current_user.admin? or current_user.coordinador? or current_user.tutor?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
    @tutorial = Tutorial.find(params[:id])
    @tutorial.destroy
    redirect_to tutorials_path
  
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutorial
      @tutorial = Tutorial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutorial_params
      params.require(:tutorial).permit(
        :subject, :dates, :timestart ,:timeend, 
        :typetutorials_attributes=> [:id,:type_id, :tutorial_id], 
         :annotations_attributes=>[:id,:comment,:times,:user_id]
        )
    end
def type_params
      params.require(:tutorial).permit(
        :typetutorials_attributes=> [:type_id, :tutorial_id])
    end

   

end
