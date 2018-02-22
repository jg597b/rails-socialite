class Invitation < ApplicationRecord
  belongs_to :attended_event, class_name: "Event"
  belongs_to :user

  validates :user_id ,presence: true
end
