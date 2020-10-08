# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
prepend_before_action :require_no_authentication, only: :cancel

  # GET /resource/sign_up
   def new
     super
   end

  # POST /resource
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
   
      @user.password= @user.email
    @user.password_confirmation=@user.email
    if @user.save
    
         redirect_to request.referrer
       flash[:noticep] = "Usuario creado con éxito. " 
    else
      redirect_to request.referrer
      flash[:noticen] = "Error al guardar. " 
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
   end

   private
   def user_params
      params.require(:user).permit(:firstname, :lastname,:rolesdevise, :role_id,:password, :password_confirmation, :email, :department_id)
    end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
