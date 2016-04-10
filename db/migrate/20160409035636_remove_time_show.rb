class RemoveTimeShow < ActiveRecord::Migration
  def up
    remove_column(:police_alerts, :time_show)
    remove_column(:fire_alerts, :time_show)
  end

  def down
    add_column(:police_alerts, :time_show, :datetime)
    add_column(:fire_alerts, :time_show, :datetime)
  end
end
