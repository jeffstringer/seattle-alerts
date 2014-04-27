class RemoveZipcodeFromSubscribers < ActiveRecord::Migration
  def change
    remove_column :subscribers, :zipcode, :string
  end
end
