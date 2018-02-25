class Event < ApplicationRecord
  require 'csv'

  belongs_to :host
  has_many :invitations, class_name: "Invitation", foreign_key: "attended_event_id", dependent: :destroy


  enum event_type: [:public, :invite], _prefix: true

  validates :event_name, :capacity, :event_start, :event_end, :rsvp_start, :rsvp_end, :event_type, :venue_addr1, :venue_city, :venue_state, :venue_zip, presence: true

  def self.get_upcoming_public_events
    self.where(event_type: :public).where('`event_start` >= ?', Time.now)
  end

  def self.get_upcoming_public_events_and_user(user)
    self.get_upcoming_public_events +  Event.joins(invitations: :user).where("users.id = ?", user.id)
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

  def self.get_events_by_user(user_id)
    self.where(host_id: host_id).where('`event_start` < ?', Time.now)
  end

  def number_of_seats_left
    capacity - invitations.where(accepted: true).sum(:guest_count)
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
    #if there is no users in the list, show all Users
    if invited_users_listing.empty?
      User.all
    else
      User.where.not(id:invited_users_listing)
    end
  end

  # users who are invited but have not accepted
  def pending_users_list
    User.where(id: pending_invitations)
  end

  # users who are invited and have accepted
  def attendees
    User.where(id: attendees_ids)
  end

  def self.to_csv_user_info(event, invited_users)
    attributes = %w{status first_name last_name email phone_number guests}

    CSV.generate(headers: true) do |csv|
      csv << attributes
      invited_users.each do |user|
        invitation = Invitation.find_by(attended_event: event,user: user)
        csv << [invitation.accepted? ? "yes" : "no", user.first_name, user.last_name, user.email_addr, user.phone, invitation.guest_count]
      end
    end
  end


  def invited_users
    User.where(id: invited_users_listing)
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