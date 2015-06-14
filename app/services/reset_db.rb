class ResetDB

  def self.call
    if Rails.env.development?
      PoliceAlert.destroy_all
      FireAlert.destroy_all
    elsif count_all >= 9900 
      PoliceAlert.destroy_all
      FireAlert.destroy_all
    end
  end

  def self.count_all
    PoliceAlert.count + FireAlert.count + PoliceNotification.count + FireNotification.count
  end
end