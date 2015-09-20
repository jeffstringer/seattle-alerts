class FireNotification < ActiveRecord::Base
  class << self
    include Notification
  end

  belongs_to :subscriber
  belongs_to :fire_alert
end