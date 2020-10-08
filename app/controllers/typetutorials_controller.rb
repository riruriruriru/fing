class TypetutorialsController < ApplicationController
 ## before_action :set_typetutorial, only: [:show, :edit, :update, :destroy]
 
  before_action :authenticate_user!
  before_action :notification 

  # GET /typetutorials
  # GET /typetutorials.json
  def index
    redirect_to '/404'
  end

  # GET /typetutorials/1
  # GET /typetutorials/1.json
  def show
    redirect_to '/404'
  end

  # GET /typetutorials/new
  def new
    @typetutorial = Typetutorial.new
  end

  # GET /typetutorials/1/edit
  def edit
  end

  # POST /typetutorials
  # POST /typetutorials.json
  def create
    @typetutorial = Typetutorial.new(typetutorial_params)

    respond_to do |format|
      if @typetutorial.save
        format.html { redirect_to @typetutorial, notice: 'Typetutorial was successfully created.' }
        format.json { render :show, status: :created, location: @typetutorial }
      else
        format.html { render :new }
        format.json { render json: @typetutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /typetutorials/1
  # PATCH/PUT /typetutorials/1.json
  def update
    respond_to do |format|
      if @typetutorial.update(typetutorial_params)
        format.html { redirect_to @typetutorial, notice: 'Typetutorial was successfully updated.' }
        format.json { render :show, status: :ok, location: @typetutorial }
      else
        format.html { render :edit }
        format.json { render json: @typetutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /typetutorials/1
  # DELETE /typetutorials/1.json
  def destroy
    @typetutorial.destroy
    respond_to do |format|
      format.html { redirect_to typetutorials_url, notice: 'Typetutorial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_typetutorial
      @typetutorial = Typetutorial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def typetutorial_params
      params.require(:typetutorial).permit(:type_id, :tutorial_id)
    end
end
