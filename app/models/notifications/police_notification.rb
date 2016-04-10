class PoliceNotification < ActiveRecord::Base
  class << self
    include Notification
  end

  belongs_to :subscriber
  belongs_to :police_alert
end
