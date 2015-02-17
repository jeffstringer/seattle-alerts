class PoliceNotification < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :police_alert
end
