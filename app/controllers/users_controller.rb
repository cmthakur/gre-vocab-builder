class UsersController < ApplicationController

  before_filter :authenticate_user!

  def history
    @user_words = current_user.user_words.includes(:word).order("created_at DESC")
  end

end