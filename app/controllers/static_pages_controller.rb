class StaticPagesController < ApplicationController
  def index
    @police_alerts = PoliceAlert.alerts
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

    @fire_alerts = FireAlert.alerts
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
    @current_subscriber = current_subscriber
    @home = Gmaps4rails.build_markers(@current_subscriber) do |current_subscriber, marker|
      marker.lat(current_subscriber.latitude)
      marker.lng(current_subscriber.longitude)
      marker.json({:id => current_subscriber.id })
      marker.picture({
        # http://mapicons.nicolasmollet.com/
        "url" => view_context.image_path('/assets/home.png'),
        "width" => 32,
        "height" => 37
      })
      marker.infowindow render_to_string(:partial => '/layouts/current_subscriber_infowindow', :locals => { :subscriber => current_subscriber } )
    end
    @subscribers = Subscriber.all
    @police_alerts_all = PoliceAlert.all
    @police_alerts_all.each do |p_alert|
      @subscribers.each do |subscriber|
        @police_notification = PoliceNotification.new
        @police_notification.subscriber_id = subscriber.id
        @police_notification.police_alert_id = p_alert.id
        @police_notification.save if subscriber.distance_to([p_alert.latitude, p_alert.longitude]) <= subscriber.radius
      end
    end
    @fire_alerts_all = FireAlert.all
    @fire_alerts_all.each do |f_alert|
      @subscribers.each do |subscriber|
        @fire_notification = FireNotification.new
        @fire_notification.subscriber_id = subscriber.id
        @fire_notification.fire_alert_id = f_alert.id
        @fire_notification.save if subscriber.distance_to([f_alert.latitude, f_alert.longitude]) <= subscriber.radius
      end
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
