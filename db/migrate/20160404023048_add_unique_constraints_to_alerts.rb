class AddUniqueConstraintsToAlerts < ActiveRecord::Migration
  def up
    add_index(:police_alerts, :general_offense_number, unique: true)
    add_index(:fire_alerts, :incident_number, unique: true)
  end

  def down
    remove_index(:police_alerts, :general_offense_number)
    remove_index(:fire_alerts, :incident_number)
  end
end
