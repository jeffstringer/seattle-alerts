class RemoveLatitudeFromPoliceAlerts < ActiveRecord::Migration
  def change
    remove_column :police_alerts, :latitude, :string
  end
end
