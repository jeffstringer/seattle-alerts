module DataSupport

  def raw_police_data
    [ {
        "event_clearance_code"=>"177",
        "cad_event_number"=>"14000396695",
        "event_clearance_subgroup"=>"LIQUOR VIOLATIONS",
        "event_clearance_group"=>"LIQUOR VIOLATIONS",
        "cad_cdw_id"=>"2211952",
        "event_clearance_date"=>"2013-11-28T08:43:00",
        "zone_beat"=>"E1",
        "initial_type_description"=>"DETOX - REQUEST FOR",
        "district_sector"=>"E",
        "initial_type_subgroup"=>"LIQUOR VIOLATIONS",
        "incident_location"=>{"needs_recoding"=>false, "longitude"=>"-122.320863689", "latitude"=>"47.619323645"},
        "hundred_block_location"=>"1XX BLOCK OF BROADWAY E",
        "general_offense_number"=>"2014396695",
        "event_clearance_description"=>"LIQUOR VIOLATION - INTOXICATED PERSON",
        "longitude"=>"-122.320863689",
        "latitude"=>"47.619323645",
        "initial_type_group"=>"LIQUOR VIOLATIONS",
        "census_tract"=>"7400.3005"},
       {"event_clearance_code"=>"245",
        "cad_event_number"=>"14000396683",
        "event_clearance_subgroup"=>"DISTURBANCES",
        "event_clearance_group"=>"DISTURBANCES",
        "cad_cdw_id"=>"2211938",
        "event_clearance_date"=>"2013-11-28T08:31:00",
        "zone_beat"=>"G2",
        "initial_type_description"=>"DISTURBANCE, MISCELLANEOUS/OTHER",
        "district_sector"=>"G",
        "initial_type_subgroup"=>"DISTURBANCES",
        "incident_location"=>{"needs_recoding"=>false, "longitude"=>"-122.31276312", "latitude"=>"47.597490885"},
        "hundred_block_location"=>"RAINIER AV S / S WELLER ST",
        "general_offense_number"=>"2014396683",
        "event_clearance_description"=>"DISTURBANCE, OTHER",
        "longitude"=>"-122.312763120",
        "latitude"=>"47.597490885",
        "initial_type_group"=>"DISTURBANCES",
        "census_tract"=>"9000.2004"} 
    ]
  end

  def raw_fire_data
    [
      {"address"=>"1000 4th Av",
      "longitude"=>"-122.332909",
      "latitude"=>"47.606088",
      "incident_number"=>"F150019090",
      "datetime"=>1424468700,
      "type"=>"Bark Fire",
      "report_location"=>{"needs_recoding"=>false, "longitude"=>"-122.332909", "latitude"=>"47.606088"}},
      {"address"=>"3715 West Stevens Way Ne",
      "longitude"=>"-122.307565",
      "latitude"=>"47.652021",
      "incident_number"=>"F150019128",
      "datetime"=>1424475660,
      "type"=>"Bark Fire",
      "report_location"=>{"needs_recoding"=>false, "longitude"=>"-122.307565", "latitude"=>"47.652021"}}
    ]
  end
end