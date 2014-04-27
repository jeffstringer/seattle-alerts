class AddLatitudeAndLongitudeToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :latitude, :float
    add_column :subscribers, :longitude, :float
  end
end
