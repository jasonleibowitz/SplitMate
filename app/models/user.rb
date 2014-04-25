class User < ActiveRecord::Base

  has_secure_password
  belongs_to :apartment
  has_many :chores

end
