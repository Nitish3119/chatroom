class Request < ApplicationRecord
  belongs_to :room

  def owner
    User.find_by(id: self.requester).username
  end
end
