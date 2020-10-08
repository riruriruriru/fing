class UsersController < ApplicationController
  before_action :authenticate_user!


  def show
    if params[:id].to_i == current_user.id
      @user = User.find_by(id: params[:id])
    else
      redirect_to '/404'
      flash[:noticen] = "Usted no tiene permiso de ver este perfil" 
    end

  end


   def new
    @user = User.new
   end

    def create
    @user = User.new(user_params)
   
   
    case @user.role_id # a_variable is the variable we want to compare
      when 1  
        @user.rolesdevise = :admin

      when 2
        @user.rolesdevise = :tutor 

      when 3
        @user.rolesdevise = :coordinador 

      else
        @user.rolesdevise = :supervisor 
        
      end
    #TO-DO:  Aquí ver la opción de cambiar contraseña.
    @user.password= @user.email
    @user.password_confirmation=@user.email
    @user.firstname.capitalize!
    @user.lastname.capitalize!
    if @user.save
    
            flash[:noticep] = "Usuario añadido con éxito" 
            redirect_to request.referrer
         
    else
      redirect_to request.referrer
      flash[:noticen] = "Error al guardar. " 
    end

    
  end


  def edit
  @user = User.find(params[:id])   
  end 

  def update 
   @user = User.find(params[:id]) 

     
      
    if @user.update_attributes(user_params)
        case @user.role_id # a_variable is the variable we want to compare
          when 1  
            params[:user][:rolesdevise]= 'admin' 

          when 2
            params[:user][:rolesdevise]= 'tutor'

          when 3
            params[:user][:rolesdevise]= 'coordinador'

          else
            params[:user][:rolesdevise] = 'supervisor' 
            
          end
          if params[:user][:firstname].blank? || params[:user][:lastname].blank?

            flash[:noticep] = "Contraseña cambiada correctamente" 
          end
          if @user.update_attributes(user_params)
            redirect_to request.referrer
            flash[:noticep] = "Datos actualizados correctamente" 
          end
       
    end   
  end

   def destroy
   @user = User.find(params[:id])   
   
   if @user.destroy
        redirect_to request.referrer
       flash[:noticep] = "Usuario creado con éxito. " 
    else
      redirect_to request.referrer
      flash[:noticen] = "Error al guardar. " 
    end

   end

    private
   
    def user_params
      params.require(:user).permit(:firstname, :lastname,:rolesdevise, :role_id,:password, :password_confirmation, :email, :department_id)
    end
    
end