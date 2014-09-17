class AuthenticationProvider < ActiveRecord::Base
  has_many :users, class: "User"
  has_many :user_authentications
end
