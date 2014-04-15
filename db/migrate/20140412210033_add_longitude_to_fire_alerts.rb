class AddLongitudeToFireAlerts < ActiveRecord::Migration
  def change
    add_column :fire_alerts, :longitude, :float
  end
end
