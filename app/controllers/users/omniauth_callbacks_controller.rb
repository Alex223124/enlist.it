class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:success] = 'Signed in successfully.'
      sign_in @user, event: :authentication
      redirect_to services_path
    else
      flash[:error] = 'Something went wrong.'
      redirect_to root_path
    end
  end
end
