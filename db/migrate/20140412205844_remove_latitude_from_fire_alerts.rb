class RemoveLatitudeFromFireAlerts < ActiveRecord::Migration
  def change
    remove_column :fire_alerts, :latitude, :string
  end
end
