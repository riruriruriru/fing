class StudentsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :notification 
  before_action :readPeriod
  before_action :readCareer


 def index
   require 'rest-client'
   require 'json'

   unless current_user.admin? or current_user.coordinador? or current_user.tutor?
     redirect_to '/', :alert => "Acceso denegado." 
   end
   
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

   @students = Student.all



 end

 


 def show
   unless current_user.admin? or current_user.coordinador? or current_user.tutor?
     redirect_to '/', :alert => "Acceso denegado." 
   end
   idd=params[:id]
   student = Student.find(params[:id])
   @coordinadores= User.where(role_id:3)




   if student.status==true
     if @student= Student.find(params[:id])
         if current_user.tutor?
           @studentannotations = Studentannotation.where(student_id:idd).where(user_id:current_user.id).order("created_at DESC")
         else
           @studentannotations = Studentannotation.where(student_id:idd).order("created_at DESC")
         end

         careers = Career.all
           careers.each do |career|
               if @student.careercode == career.code
                 @career = career.name
               end
             end

           asistutorials = StudentTutorial.all
           @presente=0
           @ausente=0
             asistutorials.each do |asistencia|
               if @student.id == asistencia.student_id
                   if asistencia.present== true
                      @presente= @presente+ 1
                   else
                      @ausente= @ausente+1
                   end

               end 
         

           #roles
           @user= User.all
           @roles=Role.all
           #@nameandrole= User.nameandrole(@user)





       end

       end
   else
     redirect_to '/404'
   end

   if student.blank?
     redirect_to '/404'
   end
 end
  

 def new
   unless current_user.admin? or current_user.coordinador?
     redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
   end
   @student = Student.new
   @student.studentannotations.build
 end

 def create
   unless current_user.admin? or current_user.coordinador? or current_user.tutor?
     redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
   end 
   if current_user.admin? or current_user.coordinador? or current_user.tutor?  
       @student = Student.new(student_params)
       @student.firstname.upcase!
       @student.lastname.upcase!
        @student.lastnamema.upcase! 
        @student.status = true  
       if @student.save   
         flash[:noticep] = 'Estudiante añadido con éxito'   
         redirect_to :action => "index"  
       else   
         flash[:noticen] = 'Error al añadir estudiante'   
         render :new   
       end 
   else
     redirect_to '/', :alert => "Acceso denegado."
    end   
 end 

 def edit
 unless current_user.admin? or current_user.coordinador?
     redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
   end   
   @student = Student.find(params[:id])   
 end 

 def update 
   unless current_user.admin? or current_user.coordinador? or current_user.tutor?
     redirect_to '/', :alert => "Acceso denegado." 
   end

   @student = Student.find(params[:id])
   
   
   if current_user.admin? or current_user.coordinador?
       if @student.update_attributes(student_params)
       
           flash[:noticep] = 'Información actualizada'    
           redirect_to request.referrer
          
       else   
         flash[:noticen] = "Error al actualizar. " 
         redirect_to request.referrer 
       end 
   elsif current_user.tutor?
     if @student.update_attributes(studentannotations_params)
     
           redirect_to request.referrer
          
       else   
         
         redirect_to request.referrer 
       end
   end  
 end

   def destroy
      
   @student = Student.find(params[:id])   
   if current_user.admin? or current_user.coordinador?
     if @student.update(status:false) 
     flash[:noticep] = 'Estudiante borrado'   
     redirect_to request.referrer  
     else   
       flash[:noticen] = 'Error al eliminar estudiante'   
       redirect_to request.referrer
     end
   else
       flash[:noticen] = 'Usted no tiene permisos para eliminar este estudiante'   
       redirect_to request.referrer 
   end   
 end   

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_student
     @tutorial = Tutorial.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def student_params
     params.require(:student).permit(
       :rut,:firstname,:lastname,:email,:careercode,:level,:dv,:lastnamema,:status,:entry, :department_id,
       :studentannotations_attributes=> [:times,:comment,:statusannotation_id,:typeannotation_id,:user_id, :id,:derivation]
       )
   end

   def studentannotations_params
     params.require(:student).permit( 
       :studentannotations_attributes=> [:times,:comment,:statusannotation_id,:typeannotation_id,:user_id, :id,:derivation]
       )
   end



end