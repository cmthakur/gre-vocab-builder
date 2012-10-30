class Users::SessionsController < Devise::SessionsController

  def create
    User.find_or_create_by_email(params[:user][:email])
    params[:user][:password] = User::DEFAULT_PASSWORD
    super
  end
end