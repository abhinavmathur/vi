class RegistrationsController < Devise::RegistrationsController
  private
  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :description, :country_code, :affiliate_countries)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end