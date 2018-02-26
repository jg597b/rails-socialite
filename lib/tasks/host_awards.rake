require 'csv'

task awards: :environment do
    pop_hosts= Host.group('business_name').joins(events: :invitations).order('sum_guest_count asc').sum(:guest_count).first(5)
    attributes = %w{Business_Name RSVP}
    CSV.open('./awards.csv',"wb") do |csv|
      csv << attributes
      pop_hosts.each do |host|
        csv << [host[0], host[1]]
      end
    end
end