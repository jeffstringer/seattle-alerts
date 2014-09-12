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
end
