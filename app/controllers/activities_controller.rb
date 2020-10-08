class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :notification 
  require 'json'
  skip_before_action :verify_authenticity_token

  # GET /activities
  # GET /activities.json
  def index
    unless current_user.admin? or current_user.coordinador?
      redirect_to '/', :alert => "Acceso denegado."
    end

    @eventos = []
    @eventos2=[]

    @activities = Activity.all
    @activitys = Activity.all
    @tutorials= Tutorial.all

    @eventos = @activitys.each_with_object([]) {|cal, array| array << cal.formatjson }.to_json
    @eventos2= @tutorials.each_with_object([]) {|cal, array| array << cal.formatTutorialjson }.to_json
  
    respond_to do |format|
        format.html
        format.json { render :json => @activities.to_json }
    end

    
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    unless current_user.admin? or current_user.coordinador?
       redirect_to request.referrer
      flash[:noticen] = "Acceso denegado" 
    end
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
        flash[:noticep] = "Actividad creada con éxito." 
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
        flash[:noticen] = "Error, la actividad no se pudo crear." 
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    
      if @activity.update(activity_params)
        
        flash[:noticep] = "Actividad modificada con éxito." 
      else
       
      end
  
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    if @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
    flash[:noticep] = "Actividad eliminada con éxito." 
  else
    flash[:noticen] = "Error, actividad no se pudo eliminar." 
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:title, :start, :end,:color,:groupId,:description)
    end
end
