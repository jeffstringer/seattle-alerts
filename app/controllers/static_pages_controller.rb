class StaticPagesController < ApplicationController
  def index
    @current_subscriber = current_subscriber
    current_subscriber.nil? ? @police_alerts = PoliceAlert.alerts : @police_alerts = PoliceAlert.subscriber_alerts(current_subscriber)
    @police_hash = Gmaps4rails.build_markers(@police_alerts) do |police_alert, marker|
      marker.lat(police_alert.latitude)
      marker.lng(police_alert.longitude)
      marker.json({:id => police_alert.id })
      marker.picture({
        # http://mapicons.nicolasmollet.com/
        "url" => view_context.image_path('/assets/police.png'),
        "width" => 32,
        "height" => 37
      })
      marker.infowindow render_to_string(:partial => '/layouts/police_alerts_infowindow', :locals => { :police_alert => police_alert } )
    end

    current_subscriber.nil? ? @fire_alerts = FireAlert.alerts : @fire_alerts = FireAlert.subscriber_alerts(current_subscriber)
    @fire_hash = Gmaps4rails.build_markers(@fire_alerts) do |fire_alert, marker|
      marker.lat(fire_alert.latitude)
      marker.lng(fire_alert.longitude)
      marker.picture({
        # http://mapicons.nicolasmollet.com/
        "url" => view_context.image_path('/assets/fire.png'),
        "width" => 32,
        "height" => 37
      })
      marker.infowindow render_to_string(:partial => '/layouts/fire_alerts_infowindow', :locals => { :fire_alert => fire_alert } )
    end

  end

  private
    def police_notification_params
      params.require(:police_notification).permit(:user_id, :police_alert_id)
    end

    def fire_notification_params
      params.require(:fire_notification).permit(:user_id, :fire_alert_id)
    end
end
