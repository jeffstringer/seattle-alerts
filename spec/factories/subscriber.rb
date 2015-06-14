FactoryGirl.define do
  factory :subscriber do
    email 'chairman@starbucks.com'
    street '1912 Pike Pl'
    password 'coffee'
    password_confirmation 'coffee'
    radius 1.0
  end

  factory :subscriber2, class: Subscriber do
    email 'taster@starbucks.com'
    street '1912 Pike Pl'
    password 'coffee'
    password_confirmation 'coffee'
    radius 0.5
  end
end