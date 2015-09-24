class MainController < ApplicationController
  def index
    current_subscriber.nil? ? @police_alerts = PoliceAlert.past_day_alerts : @police_alerts = PoliceAlert.subscriber_past_day_alerts(current_subscriber.id)
    police_json
    current_subscriber.nil? ? @fire_alerts = FireAlert.past_day_alerts : @fire_alerts = FireAlert.subscriber_past_day_alerts(current_subscriber.id)
    fire_json
  end

  private
    def police_json
      @police_json = Gmaps4rails.build_markers(@police_alerts) do |police_alert, marker|
        marker.lat(police_alert.latitude)
        marker.lng(police_alert.longitude)
        marker.json({:id => police_alert.id })
        icon = IconSetter.call(police_alert.event_clearance_description)
        marker.picture({ "url" => view_context.image_path(icon), "width" => 32, "height" => 37 })
        marker.infowindow render_to_string(:partial => '/layouts/police_alerts_infowindow', :locals => { :police_alert => police_alert } )
      end
    end

    def fire_json
      @fire_json = Gmaps4rails.build_markers(@fire_alerts) do |fire_alert, marker|
        marker.lat(fire_alert.latitude)
        marker.lng(fire_alert.longitude)
        marker.picture({ "url" => view_context.image_path('fire.png'), "width" => 32, "height" => 37 })
        marker.infowindow render_to_string(:partial => '/layouts/fire_alerts_infowindow', :locals => { :fire_alert => fire_alert } )
      end
    end

    def police_notification_params
      params.require(:police_notification).permit(:user_id, :police_alert_id)
    end

    def fire_notification_params
      params.require(:fire_notification).permit(:user_id, :fire_alert_id)
    end
end
