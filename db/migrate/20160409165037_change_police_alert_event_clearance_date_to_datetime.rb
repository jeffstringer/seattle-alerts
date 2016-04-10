class ChangePoliceAlertEventClearanceDateToDatetime < ActiveRecord::Migration
  def up
    remove_column :police_alerts, :event_clearance_date
    add_column :police_alerts, :event_clearance_date, :datetime
  end

  def down
    remove_column :police_alerts, :event_clearance_date
    add_column :police_alerts, :event_clearance_date, :string
  end
end
