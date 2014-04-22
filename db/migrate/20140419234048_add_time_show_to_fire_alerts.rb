class AddTimeShowToFireAlerts < ActiveRecord::Migration
  def change
    add_column :fire_alerts, :time_show, :datetime
  end
end
