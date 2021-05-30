class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, 
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :images
  has_many :comments
end
