class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:success] = 'Signed in successfully.'
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = 'Something went wrong.'
      redirect_to new_user_session_path
    end
  end
end
