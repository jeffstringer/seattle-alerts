class ChangeLatitudeToPoliceAlerts < ActiveRecord::Migration
  def up 
    change_table :police_alerts do |t|
      t.change :latitude, :float
    end
  end

  def down
    change_table :police_alerts do |t|
      t.change :latitude, :string
    end
  end


  #def change
  #  add_column    :police_alerts, :latitude, :float
  #end
end
