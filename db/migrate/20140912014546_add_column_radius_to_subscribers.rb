class AddColumnRadiusToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :radius, :float
  end
end
