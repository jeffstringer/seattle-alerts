FactoryGirl.define do
  factory :fire_alert do
    address "2132 Boyer Av E"
    datetime "Thu Feb  5, 2015 at 10:26 AM"
    incident_number "F150013312"
    latitude 47.6101799
    longitude -122.3423913 
    fire_type "Bark Fire"
    time_show "2015-02-05 18:26:00"
    created_at 10.minutes.ago
    updated_at 10.minutes.ago
  end
end