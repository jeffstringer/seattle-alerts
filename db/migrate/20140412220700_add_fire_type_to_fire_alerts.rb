class AddFireTypeToFireAlerts < ActiveRecord::Migration
  def change
    add_column :fire_alerts, :fire_type, :string
  end
end
