class AddLatitudeToPoliceAlerts < ActiveRecord::Migration
  def change
    add_column :police_alerts, :latitude, :float
  end
end
