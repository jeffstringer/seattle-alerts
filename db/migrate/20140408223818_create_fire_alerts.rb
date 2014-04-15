class CreateFireAlerts < ActiveRecord::Migration
  def change
    create_table :fire_alerts do |t|
      t.string :address
      t.string :type
      t.string :datetime
      t.string :latitude
      t.string :longitude
      t.string :incident_number

      t.timestamps
    end
  end
end
