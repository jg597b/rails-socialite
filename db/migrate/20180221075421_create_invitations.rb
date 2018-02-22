class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.integer :attended_event_id
      t.references :user, foreign_key: true
      t.boolean :accepted, default: false
      t.integer :guest_count

      t.timestamps
    end
  end
end
