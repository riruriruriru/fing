class AdminController < ApplicationController
   before_action :authenticate_user!
     before_action :readCareer

  def index
  	unless current_user.admin?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
    @academic_units = AcademicUnit.all
    @users = User.all
    @subjects = Subject.all
    @user = User.new
    @department= Department.all
    @careers= Career.all
    @codes=[]
    count=0
    @careers.each do |c|
        if c.id == @carreers4department[count]
            @codes<< c.code
           count=count+1
         end
         
    end

    @career=Career.where(code:@codes[0]).or(Career.where(code:@codes[1])).or(Career.where(code:@codes[2])).or(Career.where(code:@codes[3])).or(Career.where(code:@codes[4]))
    

  
  end

  def show
  	
      redirect_to '/404'
  end








  def actualize
    if poblarbd
      redirect_to request.referrer
      if @count_poblar==0
        flash[:noticep] = "No hay nuevos estudiantes para añadir, se encuentran actualizados." 
      elsif @count_poblar==1
         flash[:noticep] = "Se añadió "+@count_poblar.to_s+" estudiante."
       else
          flash[:noticep] = "Se añadieron "+@count_poblar.to_s+" estudiantes."
      end
    else
      redirect_to request.referrer
         flash[:noticen] = "Error al actualizar estudiantes"
    end
  end

  def chooseYear
     unless current_user.admin?
      redirect_to '/', :alert => "Acceso denegado." 
     end
    begin
         year = params["periodo(1i)"]

        
        File.open('periodFile.txt', 'w') do |file|

            file.puts year+"\n"
          
        end
         redirect_to request.referrer
         flash[:noticep] = "Periodo seleccionado correctamente"
  rescue
    redirect_to request.referrer
    flash[:noticen] = "Error al seleccionar periodo"
  end
    
   
  end

  def upload
    unless current_user.admin? 
      redirect_to '/', :alert => "Acceso denegado." 
    end

     names=[]
    
     @carreers4department.each_with_index do |id,index|
        uploaded_file= params["picture#{index}".to_sym]

       File.open(Rails.root.join(uploaded_file.original_filename), 'wb') do |file|
          if file.write(uploaded_file.read)
              names << uploaded_file.original_filename       
          end
       end
     end
     fileDesertion(names)
    redirect_to request.referrer
    flash[:noticep] = "Archivos guardados. " 
    

         
     
  end





  def fileDesertion(names)


    File.open('desertionFiles.txt', 'w') do |file|

      names.each do  |n|
        file.puts n+"\n"
      
      end
    end
   
  end

def subject_params
      params.require(:subject).permit(:name, :level)
    end


end
