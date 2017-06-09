class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :ensure_school_district_22, only: [:google_oauth2]

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "google") if is_navigational_format?
    else
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private

  def ensure_school_district_22
    auth = request.env["omniauth.auth"]
    unless auth.info.email.end_with?("sd22learns.ca")
      redirect_to root_path, notice: "Only sd22 people can use this website"
    end
  end
end