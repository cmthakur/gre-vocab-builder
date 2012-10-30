class User < ActiveRecord::Base
  attr_accessible :email, :encrypted_password

  validates_email_format_of :email
  validates_uniqueness_of :email

  devise :database_authenticatable

  has_many :user_words


  DEFAULT_PASSWORD="nopassword"

  before_validation do |user|
    user.password = user.password_confirmation = User::DEFAULT_PASSWORD
  end
end
