class Room < ApplicationRecord
  validates :title, presence:true
  has_many :messages, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :user, through: :members
  scope :public_rooms, -> { where(is_private: false) }
  scope :private_rooms, -> { where(is_private: true) }

  def self.except(rooms_to_exclude)
    where.not(id: rooms_to_exclude.pluck(:id))
  end
end
