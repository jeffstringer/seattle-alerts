class AddLatitudeToFireAlerts < ActiveRecord::Migration
  def change
    add_column :fire_alerts, :latitude, :float
  end
end
