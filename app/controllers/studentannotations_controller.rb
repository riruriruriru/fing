class StudentannotationsController < ApplicationController
  before_action :set_studentannotation, only: [:show, :edit, :update, :destroy]

   before_action :authenticate_user!

  # GET /studentannotations
  # GET /studentannotations.json
  def index
    @name=current_user.name
    studentannotation = Studentannotation.where(typeannotation_id:2).where(derivation:current_user.id).where(statusannotation_id:1) #alerta
    studentannotation.each do |ann|
      ann.update(statusannotation_id:2)
    end
    @studentannotations=Studentannotation.where(typeannotation_id:2).where(derivation:current_user.id).where(statusannotation_id:2).or(Studentannotation.where(statusannotation_id:4))
  end

  # GET /studentannotations/1
  # GET /studentannotations/1.json
  def show
    
    @student= Student.find(params[:id])
    
    
  end

  # GET /studentannotations/new
  def new
    @studentannotation = Studentannotation.new
  end

  # GET /studentannotations/1/edit
  def edit
  end

  # POST /studentannotations
  # POST /studentannotations.json
  def create
    @studentannotation = Studentannotation.new(studentannotation_params)

    respond_to do |format|
      if @studentannotation.save
        format.html { redirect_to @studentannotation, notice: 'Studentannotation was successfully created.' }
        format.json { render :show, status: :created, location: @studentannotation }
      else
        format.html { render :new }
        format.json { render json: @studentannotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /studentannotations/1
  # PATCH/PUT /studentannotations/1.json
  def update

      if @studentannotation.update(studentannotation_params)
    
        flash[:noticep] = 'Estado actualizado'    
         redirect_to request.referrer
       
    else   
      flash[:noticen] = "Error al actualizar el estado. " 

    end   
  end

  # DELETE /studentannotations/1
  # DELETE /studentannotations/1.json
  def destroy
    @studentannotation.destroy
    respond_to do |format|
      format.html { redirect_to studentannotations_url, notice: 'Studentannotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_studentannotation
      @studentannotation = Studentannotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def studentannotation_params
      params.require(:studentannotation).permit(:times, :comment, :statusannotation_id, :typeannotation_id, :user_id, :user_id)
    end
end
