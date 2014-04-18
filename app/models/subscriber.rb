class Subscriber < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates_presence_of :street, :zipcode 

  #def address
  #  [street, "Seattle", "WA", zipcode].compact.join(", ")
  #end

  #geocoded_by :address
  #after_validation :geocode
end
