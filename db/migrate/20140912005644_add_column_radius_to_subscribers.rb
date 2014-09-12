class AddColumnRadiusToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :radius, :integer
  end
end
