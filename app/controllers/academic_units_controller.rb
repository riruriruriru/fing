class AcademicUnitsController < ApplicationController
    def index
        @academic_units = AcademicUnit.all
    end
    def show
        @academic_unit = AcademicUnit.find(params[:id])
    end

    def new
        @academic_unit = AcademicUnit.new
    end

    def edit
        @academic_unit = AcademicUnit.find(params[:id])
    end

    def create
        @academic_unit = AcademicUnit.new(academic_unit_params)
       
        if @academic_unit.save
            redirect_to @academic_unit
        else 
            render 'new'
        end
    end

    def update
        @academic_unit = AcademicUnit.find(params[:id])
       
        if @academic_unit.update(academic_unit_params)
          redirect_to @academic_unit
        else
          render 'edit'
        end
    end


    def destroy
        @academic_unit = AcademicUnit.find(params[:id])
        @academic_unit.destroy
        redirect_to academic_units_path
    end
    
    private
        def academic_unit_params
        params.require(:academic_unit).permit(:name)
        end
end


