class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable

  include DeviseTokenAuth::Concerns::User

  # has_secure_token
  # has_secure_password

  # validates :full_name, presence: true

  self.per_page = 20

end
