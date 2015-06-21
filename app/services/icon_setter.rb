class IconSetter

  def self.call(police_alert)
    event_words = police_alert.event_clearance_description.split
    event_words.map!{ |word| word.gsub(/\W/, '') }
    event_words.each { |word| return icons[word] unless icons[word].nil? }
    return 'police.png'
  end

  def self.icons 
    { 
      "ANIMAL" => 'animal.png',
      "ASSAULT" =>'fight.png', 
      "BICYCLE" => 'bicycle.png', 
      "BOAT" => 'harbor.png', 
      "BURGLARY" => 'robbery.png', 
      "CASUALTY" => 'crimescene.png', 
      "DISTURBANCE" => 'police.png', 
      "DUI" => 'caraccident.png', 
      "FIGHT" => 'fight.png', 
      "FORGERY" => 'bank.png', 
      "HARASSMENT" =>'fight.png', 
      "HAZARDS" => 'hazard.png', 
      "LIQUOR" => 'liquor.png', 
      "MENTAL" => 'medicine.png', 
      "MISCHIEF" => 'mischief.png', 
      "MURDER" => 'crimescene.png', 
      "NARCOTICS" => 'drugstore.png', 
      "NOISE" => 'fireworks.png', 
      "PARKING" => 'car.png', 
      "PEDESTRIAN" =>'pedestrian.png', 
      "PROPERTY" => 'office-building.png', 
      "PROWLER" => 'robbery.png', 
      "ROBBERY" => 'shooting.png',
      "SHOPLIFT" => 'theft.png', 
      "THEFT" => 'theft.png', 
      "TRESPASS" => 'robbery.png', 
      "TRAFFIC" => 'car.png', 
      "SUSPICIOUS" => 'unk.png', 
      "VEHICLE" => 'car.png', 
      "WEAPON" => 'fight.png'
    }
  end
end