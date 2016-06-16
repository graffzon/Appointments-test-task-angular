class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :appointments, foreign_key: :creator_id
end
