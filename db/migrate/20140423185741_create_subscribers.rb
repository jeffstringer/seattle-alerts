class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email
      t.string :street
      t.string :zipcode
      t.timestamps
    end
  end
end
