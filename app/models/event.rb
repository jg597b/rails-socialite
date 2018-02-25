class Event < ApplicationRecord

  belongs_to :host
  has_many :invitations, class_name: "Invitation", foreign_key: "attended_event_id", dependent: :destroy


  enum event_type: [:public, :invite], _prefix: true

  validates :event_name, :capacity, :event_start, :event_end, :rsvp_start, :rsvp_end, :event_type, :venue_addr1, :venue_city, :venue_state, :venue_zip, presence: true

  def self.get_upcoming_public_events
    self.where(event_type: :public).where('`event_start` >= ?', Time.now)
  end

  def self.get_past_public_events
    self.where(event_type: :public).where('`event_start` < ?', Time.now)
  end

  def self.get_upcoming_events_by_host(host_id)
    self.where(host_id: host_id).where('`event_start` >= ?', Time.now)
  end

  def self.get_past_events_by_host(host_id)
    self.where(host_id: host_id).where('`event_start` < ?', Time.now)
  end

  def invited_users_listing
    invited_users_list = []
    invitations.each do |invitation|
      invited_users_list << invitation.user.id
    end
    invited_users_list
  end

  # uninvited users
  def users_not_invited
    User.where.not(id: [host.id] + invited_users_listing)
  end

  # users who are invited but have not accepted
  def pending_users_list
    User.where(id: pending_invitations)
  end

  # users who are invited and have accepted
  def attendees
    User.where(id: attendees_ids)
  end

  def attendees_ids
    accepted_invitations = invitations.where(accepted: true)
    accepted_users = []
    accepted_invitations.each do |accepted_invitation|
      accepted_users << accepted_invitation.user.id
    end
    accepted_users
  end


  def pending_invitations
    pending_invitations_list = invitations.where(accepted: false)
    pending_users = []
    pending_invitations_list.each do |pending_invitation|
      pending_users << pending_invitation.user.id
    end
    pending_users
  end

end