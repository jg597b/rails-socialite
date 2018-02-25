class User < ApplicationRecord

  attr_accessor :registration_password, :registration_password_repeat

  validates :email_addr, :passwd, :first_name, :last_name, :phone, presence: true
  validates :email_addr, uniqueness: true
  has_many :invitations


  def get_invited_in(event)
    Invitation.create(attended_event: event, user: self)
  end

  def evaluate_registration
    if registration_password != registration_password_repeat
      errors.add(:registration_password, "and confirmation password don't match")
    elsif registration_password.blank?
      errors.add(:registration_password, 'required')
    end
    
    self.passwd = Digest::SHA256.hexdigest registration_password
  end

end 