class StaticPagesController < ApplicationController
  def index
    #@police_alerts = PoliceAlert.all
    @police_alerts = PoliceAlert.where(time_show: (Time.now - 1.day)..Time.now)
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

    #@fire_alerts = FireAlert.all
    @fire_alerts = FireAlert.where(time_show: (Time.now - 1.day)..Time.now)
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

  def about
  end
end