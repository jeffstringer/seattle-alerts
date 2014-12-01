FactoryGirl.define do
  factory :subscriber do
    email 'chairman@starbucks.com'
    street '1912 Pike Pl'
    password 'coffee'
    password_confirmation 'coffee'
    latitude 47.6101798
    longitude -122.3423919
    radius 0.5
  end

  factory :subscriber_update, class: Subscriber do
    email 'chairman@starbucks.com'
    street '1912 Pike Pl'
    password 'coffee'
    password_confirmation 'coffee'
    latitude 47.6101798
    longitude -122.3423919
    radius 1.0
  end

  factory :contact do
    email 'jade@bluesky.com'
    comment 'Hey there!  Great job on the Seattle Alerts!
    It would be great if you had more choices on the main page like
    being able to see things that happened a year ago.'
  end

  factory :police_alert do
    hundred_block_location  '42XX BLOCK OF S KENYON ST'
    event_clearance_description 'PERSON WITH A GUN'
    event_clearance_date  'Thu Nov 27, 2014 at 09:44 AM'
    general_offense_number  '2014396010'
    census_tract  '11000.2009'
    latitude  47.53154278
    longitude -122.279449045
    time_show '2014-11-27 17:44:00'
    created_at  '2014-11-27 19:23:14'
    updated_at  '2014-11-27 19:23:14'
  end
end
