class IconSetter

  attr_accessor :event_description, :event_words, :new_string

  def initialize(event_description)
    self.event_description = event_description
  end

  def self.call(event_description)
    new(event_description).event_parser
  end

  def event_parser
    self.event_words = event_description.split
    self.new_string = event_words.map!{ |word| word.gsub(/\W/, '') }.join(" ")
    set
  end

  def set
    return icons[new_string] unless icons[new_string].nil?
    event_words.each { |word| return icons[word] unless icons[word].nil? }
    return 'police.png'
  end

  def icons 
    { 
      "ANIMAL" => 'animal.png',
      "ASSAULT" =>'assault.png',
      "ASSAULTS" => 'assault.png', 
      "BICYCLE" => 'bicycle.png', 
      "BURGLARY" => 'robbery.png', 
      "CASUALTY" => 'crimescene.png', 
      "DISTURBANCE" => 'police.png', 
      "DUI" => 'caraccident.png', 
      "FIGHT" => 'fight.png', 
      "FORGERY" => 'bank.png', 
      "HARASSMENT" =>'fight.png', 
      "HARBOR" => 'harbor.png', 
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
      "PROWLER" => 'prowler.png', 
      "ROBBERY" => 'shooting.png',
      "SHOPLIFT" => 'theft.png', 
      "SHOOTING" => 'shooting.png',
      "SUSPICIOUS PERSON" => 'suspicious_person.png',
      "SUSPICIOUS VEHICLE" => 'suspicious_vehicle.png',
      "THEFT" => 'theft.png', 
      "TRAFFIC" => 'car.png', 
      "TRESPASS" => 'trespass.png',
      "VEHICLE" => 'car.png', 
      "WEAPON" => 'fight.png'
    }
  end
end