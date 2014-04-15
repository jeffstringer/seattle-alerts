class StaticPagesController < ApplicationController
  def main
    @police_alerts = PoliceAlert.all
    @police_hash = Gmaps4rails.build_markers(@police_alerts) do |police_alert, marker|
      #marker.json({:id => police_alert.id })
      marker.lat(police_alert.latitude)
      marker.lng(police_alert.longitude)
      marker.picture({
        "url" => view_context.image_path('/assets/police.png'), 
        "width" => 32, 
        "height" => 37 
      })
      marker.infowindow render_to_string(:partial => '/layouts/police_alerts_infowindow', :locals => { :object => police_alert }, :layout => false, :formats => :html )
    end

    @fire_alerts = FireAlert.all
    @fire_hash = Gmaps4rails.build_markers(@fire_alerts) do |fire_alert, marker|
      marker.lat(fire_alert.latitude)
      marker.lng(fire_alert.longitude)
      marker.picture({
        "url" => view_context.image_path('/assets/fire.png'), 
        "width" => 32, 
        "height" => 37 
      })
    end
  end

  def about
  end
end
