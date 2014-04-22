class RemoveIncidentLocationFromPoliceAlerts < ActiveRecord::Migration
  def change
    remove_column :police_alerts, :incident_location, :string
  end
end
