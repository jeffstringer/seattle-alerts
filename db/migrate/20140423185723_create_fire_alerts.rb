class CreateFireAlerts < ActiveRecord::Migration
  def change
    create_table :fire_alerts do |t|
      t.string :address
      t.string :datetime
      t.string :incident_number
      t.float :latitude
      t.float :longitude
      t.string :fire_type
      t.datetime :time_show
      t.timestamps
    end
  end
end
