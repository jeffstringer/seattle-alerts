class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email
      t.string :street
      t.integer :zipcode

      t.timestamps
    end
  end
end
