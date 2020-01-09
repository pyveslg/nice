class AddAttendeesToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :attendees, :json, default: []
    add_column :contracts, :attendee_number, :integer, default: 1
  end
end
