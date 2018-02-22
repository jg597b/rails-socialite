class CreateEventLists < ActiveRecord::Migration[5.1]
  def change
    create_table :event_lists do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
