class StaticPagesController < ApplicationController
  def main
    @police_alerts = PoliceAlert.all
    @police_hash = Gmaps4rails.build_markers(@police_alerts) do |police_alert, marker|
      marker.lat(police_alert.latitude)
      marker.lng(police_alert.longitude)
      marker.picture({
        "url" => view_context.image_path('/assets/police.png'), 
        "width" => 32, 
        "height" => 37 
      })
    end
      #marker.picture({
      #  "url" => view_context.image_path('/assets/police2.png') 
      #  })
    #end

    #@fire_alerts = FireAlert.all
    #@fire_hash = Gmaps4rails.build_markers(@fire_alerts) do |fire_alert, marker|
    # marker.lat(fire_alert.latitude)
    # marker.lng(fire_alert.longitude)
    # marker.picture({
    #    "url" => view_context.image_path('/assets/fire2.png'), 
    #    "width" => 32, 
    #    "height" => 37 
    #  })
    #end
  end

  def about
  end

  def contact
  end
end
