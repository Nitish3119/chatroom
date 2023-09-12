class User < ApplicationRecord
  validates :username, presence:true, length: {minimum:3, maximum:15},  uniqueness: { case_sensitive: false }
  has_many :messages
  has_many :members
  has_many :room, through: :members
  has_secure_password

  def self.all_except(users_to_exclude)
    where.not(id: users_to_exclude.pluck(:id))
  end

end
