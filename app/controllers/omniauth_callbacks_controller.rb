class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    begin
      auth = request.env["omniauth.auth"]
    rescue Yt::Errors::RequestError => e
      flash[:danger] = "Error: #{e.description}"
      redirect_to new_user_registration_url and return
    end
    @user = User.from_omniauth(auth)
    if @user.persisted?
      flash[:success] = 'You were successfully authenticated through Google'
      @user.update_attributes(token: auth.credentials.token, refresh_token: auth.credentials.refresh_token)
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      flash[:danger] = 'We were unable to authenticate you with Google'
      redirect_to new_user_registration_url
    end
  end
end