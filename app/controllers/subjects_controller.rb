class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :notification 

  # GET /subjects
  # GET /subjects.json
  def index
     redirect_to '/404'
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
     redirect_to '/404'
  end

  # GET /subjects/new
  def new
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
    unless current_user.admin? 
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

  end

  # POST /subjects
  # POST /subjects.json
  def create
    unless current_user.admin? 
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end
    @subject = Subject.new(subject_params)

    
      if @subject.save
      redirect_to request.referrer
    flash[:noticep]='Asignatura creada exitosamente'
    else
      flash[:noticen]='Error al guardar'
    end
   
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    unless current_user.admin? 
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    
      if @subject.update(subject_params)
         redirect_to request.referrer
        flash[:noticep]='Asignatura actualizada exitosamente'
        else
          flash[:noticen]='Error al guardar'
        end
    
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    unless current_user.admin?
      redirect_to '/', :alert => "Acceso denegado." #por ahora solo un adminsitrador puede ver esto
    end

    if @subject.destroy
    redirect_to request.referrer
    flash[:noticep]='Asignatura borrada exitosamente'
    else
      flash[:noticen]='Error al borrar'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name, :level)
    end
end
