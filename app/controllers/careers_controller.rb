class CareersController < ApplicationController
   

  # GET /careers
  # GET /careers.json
  def index
    @careers = Career.all
  end

  # GET /careers/1
  # GET /careers/1.json
  def show
  end

  # GET /careers/new
  def new
    @career = Career.new
  end

  # GET /careers/1/edit
  def edit
  end

  # POST /careers
  # POST /careers.json
  def create
    @career = Career.new(career_params)

    if @career.save
    flash[:noticep] = "Carrera añadida correctamente"
    redirect_to request.referrer
    else
       flash[:noticen] = "Error al añadir carrera"
        redirect_to request.referrer
    end
   
      
   
  end

  # PATCH/PUT /careers/1
  # PATCH/PUT /careers/1.json
  def update
    respond_to do |format|
      if @career.update(career_params)
        format.html { redirect_to @career, notice: 'Career was successfully updated.' }
        format.json { render :show, status: :ok, location: @career }
      else
        format.html { render :edit }
        format.json { render json: @career.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /careers/1
  # DELETE /careers/1.json
  def destroy
    @career = Career.find(params[:id])
    if @career.destroy
    flash[:noticep] = "Carrera eliminada correctamente"
    redirect_to request.referrer
    else
       flash[:noticen] = "Error al eliminar carrera"
        redirect_to request.referrer
    end
   
  end

  private
   
    def career_params
      params.require(:career).permit(:code,:name,:department_id)
    end

end
