class AddTimeShowToPoliceAlerts < ActiveRecord::Migration
  def change
    add_column :police_alerts, :time_show, :datetime
  end
end
