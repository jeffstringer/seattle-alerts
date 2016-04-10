class ChangeFireAlertDatetimeToDatetime < ActiveRecord::Migration
  def up
    remove_column :fire_alerts, :datetime
    add_column :fire_alerts, :datetime, :datetime
  end

  def down
    remove_column :fire_alerts, :datetime
    add_column :fire_alerts, :datetime, :string
  end
end
