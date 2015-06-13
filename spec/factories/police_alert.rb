FactoryGirl.define do
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