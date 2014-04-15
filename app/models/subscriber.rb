class Subscriber < ActiveRecord::Base

  geocoded_by :street
  geocoded_by :zipcode
  after_validation :geocode
end
