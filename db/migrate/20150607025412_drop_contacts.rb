class DropContacts < ActiveRecord::Migration
  def up
    drop_table :contacts
  end

  def down
    create_table :contacts do |t|
      t.string :email
      t.string :comment
      t.timestamps
    end
  end
end
