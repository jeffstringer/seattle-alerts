class RemoveLongitudeFromFireAlerts < ActiveRecord::Migration
  def change
    remove_column :fire_alerts, :longitude, :string
  end
end
