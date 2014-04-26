class User < ActiveRecord::Base

  belongs_to :apartment
  has_many :chores
  has_many :chore_histories

  has_secure_password

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :password, length: { minimum: 5 }

end
