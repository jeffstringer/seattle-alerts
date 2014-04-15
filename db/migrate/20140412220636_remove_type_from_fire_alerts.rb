class RemoveTypeFromFireAlerts < ActiveRecord::Migration
  def change
    remove_column :fire_alerts, :type, :string
  end
end
