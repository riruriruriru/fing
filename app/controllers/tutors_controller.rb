class TutorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tutor, only: [:show, :edit, :update, :destroy]
  before_action :notification 

  # GET /tutors
  # GET /tutors.json
  def index
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    @tutors = Tutor.where(status:true)
    @careers = Career.all

  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
    tutor = Tutor.find(params[:id])
  if tutor.status==true
      if @tutor = Tutor.find(params[:id])
        if @tutor.blank?
            redirect_to '/404'
        else

        asistutorials = TutorTutorial.all
        @presente=0
        @ausente=0
          asistutorials.each do |asistencia|
            if @tutor.id == asistencia.tutor_id
              if asistencia.present== true
                 @presente= @presente+ 1
              else
                 @ausente= @ausente+1
              end

            end 
          end
        end
      end
  else
    redirect_to '/404'
  end
  end

  # GET /tutors/new
  def new
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    @tutor = Tutor.new
  end

  # GET /tutors/1/edit
  def edit
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

  end

  # POST /tutors
  # POST /tutors.json
  def create
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    @tutor = Tutor.new(tutor_params)
    @tutor.firstname= params[:tutor][:firstname].upcase!
    @tutor.lastname= params[:tutor][:lastname].upcase!
    @tutor.lastnamema= params[:tutor][:lastnamema].upcase!
    @tutor.status = true
      if @tutor.save
         flash[:noticep] = 'Tutor añadido con éxito'   
      redirect_to :action => "index"  
      else
        flash[:noticen] = 'Error al añadir tutor'   
      render :new   
      end
   
  end

  # PATCH/PUT /tutors/1
  # PATCH/PUT /tutors/1.json
  def update
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    
       @tutor = Tutor.find(params[:id])
        @tutor.firstname= params[:tutor][:firstname].upcase!
        @tutor.lastname= params[:tutor][:lastname].upcase!
        @tutor.lastnamema= params[:tutor][:lastnamema].upcase!

      if @tutor.update_attributes(tutor_params)
        
        flash[:noticep] = 'Información actualizada'    
          redirect_to request.referrer
      else
         flash[:noticen] = "Error al actualizar. " 
      end
    
  end

  # DELETE /tutors/1
  # DELETE /tutors/1.json
  def destroy
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
   @tutor = Tutor.find(params[:id])   
    if current_user.admin? or current_user.coordinador?
      if @tutor.update(status:false) 
      flash[:noticep] = 'Tutor borrado con éxito'   
      redirect_to request.referrer  
      else   
        flash[:noticen] = 'Error al eliminar tutor'   
        redirect_to request.referrer
      end
    else
        flash[:noticen] = 'Usted no tiene permisos para eliminar este tutor'   
        redirect_to request.referrer 
    end   
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor
      @tutor = Tutor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_params
  
      params.require(:tutor).permit(
        :rut,:firstname,:lastname,:email,:careercode,:level,:dv,:lastnamema,:phone,:status, :department_id)
  
    end
end
