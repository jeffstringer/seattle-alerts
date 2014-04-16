class RemoveLongitudeFromPoliceAlerts < ActiveRecord::Migration
  def change
    remove_column :police_alerts, :longitude, :string
  end
end
