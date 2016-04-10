FactoryGirl.define do
  factory :police_alert do
    hundred_block_location  '8X PIKE PLACE'
    event_clearance_description 'PERSON WITH A GUN'
    event_clearance_date '2014-11-27 17:44:00'
    general_offense_number  '2014396010'
    census_tract  '11000.2009'
    latitude  47.6087797
    longitude -122.3398541
    created_at  10.minutes.ago
    updated_at  10.minutes.ago
  end
end