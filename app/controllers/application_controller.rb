class ApplicationController < ActionController::Base
  before_action :authenticate_user!
	layout :layout_by_resource
  helper_method :notification
  helper_method :poblarbd
  helper_method :csvname
  helper_method :readFiles
  helper_method :readCareer
  helper_method :readPeriod

  private


  protect_from_forgery with: :exception
    before_action :configure_devise_params, if: :devise_controller?

    def configure_devise_params
        devise_parameter_sanitizer.permit(:sign_up) do |user|
            user.permit(:name, :email, :password, :password_confirmation)
        end
    end

  def readCareer
    @careers= Career.all
    @carreers4department=[]
      File.open('careerFile.txt', 'r') do |f1|
        while linea = f1.gets
         @departmentid = linea.chomp
        end
      end
     
    @careers.each do |car|
      if car.department_id ==  @departmentid.to_i
        @carreers4department << car.id
      end
    end


  end

  def readPeriod
      begin
        File.open('periodFile.txt', 'r') do |f1|
          while linea = f1.gets
           @per = linea.chomp
          end
        end

        if @per.blank?
          @period = Time.zone.now.year
        else
           @period = @per.to_i
        end
       rescue
         @period = Time.zone.now.year
       end

     
  end


  def csvname(name)
   
    if name.empty?
      @CAREER_1 = ""
      @CAREER_2 = ""
      @CAREER_3 = ""
      @CAREER_4 = ""

    else
      if !name[0].blank?
        @CAREER_1 = name[0]
      else
         @CAREER_1 = ""
      end
      if !name[1].blank?
        @CAREER_2 = name[1]
      else
         @CAREER_2 = ""
      end
       if !name[2].blank?
        @CAREER_3 = name[2]
       else
        @CAREER_3 = ""
        end
       if !name[3].blank?
        @CAREER_4 = name[3]
     else
       @CAREER_4 = ""
        end
      
    end

  

  end

  def readFiles
  @name=[]
      File.open('desertionFiles.txt', 'r') do |f1|
        while linea = f1.gets
          @name << linea.chomp
        end
      end
      csvname(@name) 
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  def notification
    studentannotations = Studentannotation.where(typeannotation_id:2).where(derivation:current_user.id).where(statusannotation_id:1) #alerta
    @notify=studentannotations.count
  end

  def poblarbd

    begin
    @count_poblar=0
    responses = []
    responses << JSON.parse(RestClient::Request.execute( method: :get, url: "#{ENV['URL_API']}/students/#{@period}"))
    students = responses[0]
    students.each do |student|
      if Student.where(rut:student['alu_rut']).blank?
        @count_poblar=@count_poblar+1
        @student = Student.new
        @student.studentannotations.build
        @student = Student.new(rut:student['alu_rut'], dv:student['alu_dv'],firstname:student['alu_nombre'],lastname:student['alu_paterno'],lastnamema:student['alu_materno'],email:student['alu_e_mail'],careercode:student['aca_cod_car'],level:student['aca_nivel'],entry:student['aca_agno_ing'])   
        @student.status = true
        @student.save 
      end
    end
    
    rescue RestClient::Exceptions::OpenTimeout

    rescue Errno::ECONNREFUSED

    end
  end



  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
