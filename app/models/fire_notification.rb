class FireNotification < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :fire_alert
end