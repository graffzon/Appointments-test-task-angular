class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
end
