class AddLongitudeToPoliceAlerts < ActiveRecord::Migration
  def change
    add_column :police_alerts, :longitude, :float
  end
end
