class DepartmentsController < ApplicationController


  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @department = Department.find(params[:id])
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
    @department = Department.find(params[:id])
  end

  def chooseCarrer
     unless current_user.admin?
      redirect_to '/', :alert => "Acceso denegado." 
     end
    begin
         id = params[:department]

        File.open('careerFile.txt', 'w') do |file|

            file.puts id+"\n"
          
        end
        redirect_to request.referrer
        flash[:noticep] = "Carrera seleccionada con éxito" 
  rescue
    redirect_to request.referrer
    flash[:noticen] = "Error al seleccionar carrera" 
  end
    
   
  end
  

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)
    @department.name= params[:department][:name].upcase!

  
      if @department.save
       flash[:noticep] = "Departamento añadido correctamente"
      redirect_to request.referrer
    else
       flash[:noticen] = "Error al añadir departamento"
        redirect_to request.referrer
    end
    
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy

    @department = Department.find(params[:id])
    if @department.destroy
    flash[:noticep] = "Departamento eliminada correctamente"
    redirect_to request.referrer
    else
       flash[:noticen] = "Error al eliminar departamento"
        redirect_to request.referrer
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
   

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name,:id, :academic_unit_id)
    end
end