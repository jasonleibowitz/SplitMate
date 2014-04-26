class User < ActiveRecord::Base

  belongs_to :apartment
  has_many :chores
  has_many :chore_histories

  has_secure_password

end
