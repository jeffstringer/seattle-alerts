class ResetDB

  def self.call
    count = PoliceAlert.count + FireAlert.count + PoliceNotification.count + FireNotification.count
    if count >= 9900 
      PoliceAlert.destroy_all
      FireAlert.destroy_all
    end
  end
end