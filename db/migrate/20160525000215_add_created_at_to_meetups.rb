class AddCreatedAtToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :created_at, :datetime
  end
end
